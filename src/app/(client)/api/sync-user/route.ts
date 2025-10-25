// app/api/sync-user/route.ts
import { currentUser } from "@clerk/nextjs/server";
import { NextResponse } from "next/server";
import prisma from "@/lib/prisma";

export async function POST() {
  const user = await currentUser();

  if (!user) {
    return NextResponse.json({ error: "Usuario no autenticado" }, { status: 401 });
  }

  const email = user.emailAddresses[0].emailAddress.toLowerCase();
  const first_name = user.firstName || "Sin nombre";
  const last_name = user.lastName || "Sin apellido";

  // Buscar si ya existe
  let usuario = await prisma.usuario.findUnique({
    where: { clerkId: user.id },
    include: { empleado: true, cliente: true },
  });

  if (!usuario) {
    // Crear usuario base
    usuario = await prisma.usuario.create({
      data: {
        clerkId: user.id,
        nombre: first_name,
        apellido: last_name,
        correo_electronico: email,
      },
      include: { empleado: true, cliente: true },
    });

    // Determinar si es empleado o cliente según dominio del mail
    if (email.endsWith("@smarthclothes.com")) {
      await prisma.empleado.create({
        data: { id_usuario: usuario.id_usuario, sueldo: 0 },
      });
    } else {
      await prisma.cliente.create({
        data: { id_usuario: usuario.id_usuario },
      });
    }
  } else {
    // Si ya existe, actualizamos por si cambió algo en Clerk
    await prisma.usuario.update({
      where: { clerkId: user.id },
      data: {
        nombre: first_name,
        apellido: last_name,
        correo_electronico: email,
      },
    });
  }

  return NextResponse.json({ ok: true });
}
