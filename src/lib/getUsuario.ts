import { currentUser } from "@clerk/nextjs/server";
import prisma from "@/lib/prisma";

export async function getUsuario() {
  console.log("Entrando a getUsuario...");

  const user = await currentUser();
  console.log("Usuario actual de Clerk:", user);

  if (!user) {
    throw new Error("No hay sesión activa");
  }

  const email = user.emailAddresses[0].emailAddress.toLowerCase();

  let tipo: "cliente" | "empleado" = "cliente";
  let registro = null;

  if (email.endsWith("@smarthclothes.com")) {
    tipo = "empleado";
    registro = await prisma.empleado.findUnique({ where: { clerkId: user.id } });
  } else {
    registro = await prisma.cliente.findUnique({ where: { clerkId: user.id } });
  }

  if (!registro) {
    console.warn("⚠️ El usuario existe en Clerk pero no en DB (revisar webhook)");
  }

  return { tipo, clerkId: user.id, data: registro };
}
