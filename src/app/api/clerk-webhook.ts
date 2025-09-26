import { NextRequest, NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function POST(req: NextRequest) {
  try {
    const payload = await req.json();

    // Clerk manda info del usuario creado
    const { id, email_addresses, first_name, last_name } = payload.data;
    const email = email_addresses[0].email_address.toLowerCase();

    if (email.endsWith("@smarthclothes.com")) {
      // Es EMPLEADO
      const empleadoExistente = await prisma.empleado.findFirst({
        where: { clerkId: id },
      });

      if (!empleadoExistente) {
        await prisma.empleado.create({
          data: {
            clerkId: id,
            nombre: first_name || "Sin nombre",
            apellido: last_name || "Sin apellido",
            correo_electronico: email,
            direccion: "",
            telefono: null,
            dni: null,
            sueldo: 0,
          },
        });
      }
    } else {
      // Es CLIENTE
      const clienteExistente = await prisma.cliente.findFirst({
        where: { clerkId: id },
      });

      if (!clienteExistente) {
        await prisma.cliente.create({
          data: {
            clerkId: id,
            nombre: first_name || "Sin nombre",
            apellido: last_name || "Sin apellido",
            correo_electronico: email,
            direccion: "",
            telefono: null,
            dni: null,
          },
        });
      }
    }

    return NextResponse.json({ ok: true });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "Error procesando webhook" },
      { status: 500 }
    );
  }
}
