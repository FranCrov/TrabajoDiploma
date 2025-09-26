import { currentUser } from "@clerk/nextjs/server";
import prisma from "@/lib/prisma";


export async function getUsuario() {
  console.log("Entrando a getUsuario...");

  const user = await currentUser();
  console.log("Usuario actual de Clerk:", user);

  if (!user) {
    console.log("No hay usuario activo");
    throw new Error("No hay sesión activa");
  }

  const email = user.emailAddresses[0].emailAddress.toLowerCase();
  console.log("Email normalizado:", email);

  let tipo: "cliente" | "empleado" = "cliente";
  let registro = null;

  // Caso EMPLEADO
  if (email.endsWith("@smarthclothes.com")) {
    tipo = "empleado";

    registro =
      (await prisma.empleado.findUnique({ where: { clerkId: user.id } })) ||
      (await prisma.empleado.findUnique({ where: { correo_electronico: email } }));

    console.log("Empleado encontrado:", registro);

    if (!registro) {
      console.log("Creando nuevo empleado...");
      try {
        registro = await prisma.empleado.create({
          data: {
            clerkId: user.id,
            nombre: user.firstName ?? "Sin nombre",
            apellido: user.lastName ?? "Sin apellido",
            correo_electronico: email,
            direccion: "",
            telefono: null,
            dni: null,
            sueldo: 0,
          },
        });
        console.log("Empleado creado:", registro);
      } catch (error) {
        console.error("Error creando empleado:", error);
      }
    }
  }

  // Caso CLIENTE
  else {
    registro =
      (await prisma.cliente.findUnique({ where: { clerkId: user.id } })) ||
      (await prisma.cliente.findUnique({ where: { correo_electronico: email } }));

    console.log("Cliente encontrado:", registro);

    if (!registro) {
      console.log("Creando nuevo cliente...");
      try {
        registro = await prisma.cliente.create({
          data: {
            clerkId: user.id,
            nombre: user.firstName ?? "Sin nombre",
            apellido: user.lastName ?? "Sin apellido",
            correo_electronico: email,
            direccion: "",
            telefono: null,
            dni: null,
          },
        });
        console.log("Cliente creado:", registro);
      } catch (error) {
        console.error("Error creando cliente:", error);
      }
    }
  }

  console.log("Retornando registro:", registro);
  return { tipo, clerkId: user.id, data: registro };
}
