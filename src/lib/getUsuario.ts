import { currentUser } from "@clerk/nextjs/server";
import prisma from "@/lib/prisma";

export async function getUsuario() {
  const user = await currentUser();
  if (!user) throw new Error("No hay sesión activa");

  const email = user.emailAddresses[0].emailAddress.toLowerCase();

  // Buscamos el usuario general
  const usuario = await prisma.usuario.findUnique({
    where: { clerkId: user.id },
    include: { empleado: true, cliente: true },
  });

  if (!usuario) return null;

  const tipo = usuario.empleado ? "empleado" : "cliente";

  return { tipo, clerkId: user.id, data: usuario };
}