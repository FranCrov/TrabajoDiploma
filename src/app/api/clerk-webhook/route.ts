import { Webhook } from "svix";
import { headers } from "next/headers";
import { NextResponse } from "next/server";
import prisma from "@/lib/prisma";

export async function POST(req: Request) {
  const WEBHOOK_SECRET = process.env.CLERK_WEBHOOK_SECRET;
  if (!WEBHOOK_SECRET) throw new Error("⚠️ Falta CLERK_WEBHOOK_SECRET en .env");

  const headerPayload = await headers();
  const svix_id = headerPayload.get("svix-id");
  const svix_timestamp = headerPayload.get("svix-timestamp");
  const svix_signature = headerPayload.get("svix-signature");

  if (!svix_id || !svix_timestamp || !svix_signature) {
    return NextResponse.json({ error: "Cabeceras inválidas" }, { status: 400 });
  }

  const payload = await req.json();
  const body = JSON.stringify(payload);
  const wh = new Webhook(WEBHOOK_SECRET);

  let evt: any;
  try {
    evt = wh.verify(body, {
      "svix-id": svix_id,
      "svix-timestamp": svix_timestamp,
      "svix-signature": svix_signature,
    });
  } catch (err) {
    console.error("❌ Verificación de webhook fallida:", err);
    return NextResponse.json({ error: "Firma inválida" }, { status: 400 });
  }

  const eventType = evt.type;
  console.log("📩 Evento Clerk:", eventType);

  // ------------------------------
  // Crear/Actualizar usuario
  // ------------------------------
  if (eventType === "user.created" || eventType === "user.updated") {
    const { id, email_addresses, first_name, last_name } = evt.data;
    const email = email_addresses[0].email_address.toLowerCase();

    const usuario = await prisma.usuario.upsert({
      where: { clerkId: id },
      update: {
        nombre: first_name || "Sin nombre",
        apellido: last_name || "Sin apellido",
        correo_electronico: email,
      },
      create: {
        clerkId: id,
        nombre: first_name || "Sin nombre",
        apellido: last_name || "Sin apellido",
        correo_electronico: email,
      },
    });

    if (email.endsWith("@smarthclothes.com")) {
      await prisma.empleado.upsert({
        where: { id_usuario: usuario.id_usuario },
        update: {},
        create: { id_usuario: usuario.id_usuario, sueldo: 0 },
      });
    } else {
      await prisma.cliente.upsert({
        where: { id_usuario: usuario.id_usuario },
        update: {},
        create: { id_usuario: usuario.id_usuario },
      });
    }
  }

  // ------------------------------
  // Usuario inicia sesión → aseguramos que exista
  // ------------------------------
  if (eventType === "session.created") {
    const { user_id } = evt.data;

    // Traemos los datos de Clerk
    const userResp = await fetch(`https://api.clerk.dev/v1/users/${user_id}`, {
      headers: { Authorization: `Bearer ${process.env.CLERK_SECRET_KEY}` },
    });
    const userData = await userResp.json();

    const email = userData.email_addresses[0].email_address.toLowerCase();
    const first_name = userData.first_name;
    const last_name = userData.last_name;

    // Si no existe en BD, lo creamos
    let usuario = await prisma.usuario.findUnique({ where: { clerkId: user_id } });
    if (!usuario) {
      usuario = await prisma.usuario.create({
        data: {
          clerkId: user_id,
          nombre: first_name || "Sin nombre",
          apellido: last_name || "Sin apellido",
          correo_electronico: email,
        },
      });

      if (email.endsWith("@smarthclothes.com")) {
        await prisma.empleado.create({
          data: { id_usuario: usuario.id_usuario, sueldo: 0 },
        });
      } else {
        await prisma.cliente.create({
          data: { id_usuario: usuario.id_usuario },
        });
      }
    }
  }

  // ------------------------------
  // Usuario eliminado
  // ------------------------------
  if (eventType === "user.deleted") {
    const { id } = evt.data;
    const usuario = await prisma.usuario.findUnique({ where: { clerkId: id } });
    if (usuario) {
      await prisma.empleado.deleteMany({ where: { id_usuario: usuario.id_usuario } });
      await prisma.cliente.deleteMany({ where: { id_usuario: usuario.id_usuario } });
      await prisma.usuario.delete({ where: { id_usuario: usuario.id_usuario } });
    }
  }

  return NextResponse.json({ ok: true });
}
