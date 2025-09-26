// src/app/pedidos/nuevo/page.tsx
export const runtime = "nodejs";

import prisma from "@/lib/prisma";
import NuevoPedidoForm from "./ui/NuevoPedidoForm";

export default async function Page() {
  const [clientesRaw, empresasRaw, prendasRaw] = await Promise.all([
    prisma.cliente.findMany({
      select: { id_cliente: true, nombre: true, correo_electronico: true },
      orderBy: { nombre: "asc" },
    }),
    prisma.empresa.findMany({
      select: { id_empresa: true, nombre: true },
      orderBy: { nombre: "asc" },
    }),
    // ⚠️ Sin Decimal aquí; si lo necesitas luego, conviértelo a string en el server
    prisma.prenda.findMany({
      select: { id_prenda: true, tipo: true, talla: true, color: true, id_empresa: true },
      orderBy: { tipo: "asc" },
    }),
  ]);

  // Fuerza serialización segura
  const clientes = JSON.parse(JSON.stringify(clientesRaw));
  const empresas = JSON.parse(JSON.stringify(empresasRaw));
  const prendas  = JSON.parse(JSON.stringify(prendasRaw));

  return (
    <div className="max-w-2xl mx-auto p-6 space-y-6">
      <h1 className="text-2xl font-semibold">Nuevo Pedido</h1>
      <NuevoPedidoForm clientes={clientes} empresas={empresas} prendas={prendas} />
    </div>
  );
}
