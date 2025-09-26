import { NextResponse } from "next/server";
import prisma from "@/lib/prisma";
import { Decimal } from "@prisma/client/runtime/library";

export async function POST(req: Request) {
  try {
    const { id_cliente, id_empresa, id_prenda, cantidad } = (await req.json()) as {
      id_cliente: number; id_empresa: number; id_prenda: number; cantidad: number;
    };

    if (!id_cliente || !id_empresa || !id_prenda || !cantidad || cantidad <= 0) {
      return NextResponse.json({ ok: false, error: "Datos inválidos." }, { status: 400 });
    }

    // Traer prenda (precio + validación de empresa)
    const prenda = await prisma.prenda.findUnique({
      where: { id_prenda },
      select: { precio: true, id_empresa: true },
    });
    if (!prenda) return NextResponse.json({ ok: false, error: "Prenda no encontrada." }, { status: 404 });
    if (prenda.id_empresa !== id_empresa) {
      return NextResponse.json({ ok: false, error: "La prenda no pertenece a la empresa seleccionada." }, { status: 400 });
    }

    const precioUnitario = new Decimal(prenda.precio.toString());
    const subTotal = precioUnitario.mul(cantidad);
    const today = new Date();

    const pedido = await prisma.$transaction(async (tx) => {
      const detalle = await tx.detallepedido.create({
        data: { id_prenda, cantidad, precio_unitario: precioUnitario, sub_total: subTotal },
        select: { id_detallePedido: true },
      });

      return tx.pedido.create({
        data: {
          id_cliente,
          id_empresa,
          id_detallePedido: detalle.id_detallePedido,
          estado: "NUEVO",
          fecha_pedido: today,
          cantidad,
        },
      });
    });

    return NextResponse.json({ ok: true, pedido }, { status: 201 });
  } catch (e: any) {
    console.error(e);
    return NextResponse.json({ ok: false, error: e.message ?? "Error inesperado" }, { status: 500 });
  }
}
