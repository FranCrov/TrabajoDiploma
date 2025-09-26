"use client";

import { useMemo, useState } from "react";

type Cliente = { id_cliente: number; nombre: string; correo_electronico: string };
type Empresa = { id_empresa: number; nombre: string };
type Prenda  = { id_prenda: number; tipo: string; talla: string; color: string; id_empresa: number };

export default function NuevoPedidoForm({
  clientes, empresas, prendas,
}: { clientes: Cliente[]; empresas: Empresa[]; prendas: Prenda[] }) {
  const [idCliente, setIdCliente] = useState<number | "">("");
  const [idEmpresa, setIdEmpresa] = useState<number | "">("");
  const [idPrenda, setIdPrenda]   = useState<number | "">("");
  const [cantidad, setCantidad]   = useState<number | "">("");
  const [loading, setLoading]     = useState(false);
  const [msg, setMsg]             = useState<string | null>(null);

  const prendasFiltradas = useMemo(() => {
    if (!idEmpresa) return prendas;
    return prendas.filter(p => p.id_empresa === Number(idEmpresa));
  }, [idEmpresa, prendas]);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);

    if (!idCliente || !idEmpresa || !idPrenda || !cantidad || Number(cantidad) <= 0) {
      setMsg("⚠️ Completá todos los campos y una cantidad válida.");
      return;
    }

    setLoading(true);
    try {
      const res = await fetch("/api/pedidos", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id_cliente: Number(idCliente),
          id_empresa: Number(idEmpresa),
          id_prenda:  Number(idPrenda),
          cantidad:   Number(cantidad),
        }),
      });
      const data = await res.json();
      if (!res.ok || !data.ok) throw new Error(data.error || "Error al registrar");

      setMsg("✅ Pedido registrado correctamente.");
      setIdCliente(""); setIdEmpresa(""); setIdPrenda(""); setCantidad("");
    } catch (err: any) {
      setMsg("❌ " + err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      <div className="grid gap-1">
        <label className="text-sm">Cliente *</label>
        <select className="border rounded p-2" value={idCliente}
          onChange={e => setIdCliente(e.target.value ? Number(e.target.value) : "")}>
          <option value="">Seleccioná un cliente</option>
          {clientes.map(c => (
            <option key={c.id_cliente} value={c.id_cliente}>
              {c.nombre} — {c.correo_electronico}
            </option>
          ))}
        </select>
      </div>

      <div className="grid gap-1">
        <label className="text-sm">Empresa *</label>
        <select className="border rounded p-2" value={idEmpresa}
          onChange={e => setIdEmpresa(e.target.value ? Number(e.target.value) : "")}>
          <option value="">Seleccioná una empresa</option>
          {empresas.map(emp => (
            <option key={emp.id_empresa} value={emp.id_empresa}>{emp.nombre}</option>
          ))}
        </select>
      </div>

      <div className="grid gap-1">
        <label className="text-sm">Prenda *</label>
        <select className="border rounded p-2" value={idPrenda}
          onChange={e => setIdPrenda(e.target.value ? Number(e.target.value) : "")}>
          <option value="">Seleccioná la prenda</option>
          {prendasFiltradas.map(p => (
            <option key={p.id_prenda} value={p.id_prenda}>
              {p.tipo} {p.talla} {p.color}
            </option>
          ))}
        </select>
        {!idEmpresa && <p className="text-xs text-gray-500">Elegí la empresa para filtrar prendas.</p>}
      </div>

      <div className="grid gap-1">
        <label className="text-sm">Cantidad *</label>
        <input type="number" min={1} className="border rounded p-2" value={cantidad}
          onChange={e => setCantidad(e.target.value ? Number(e.target.value) : "")}
          placeholder="Ej: 3" />
      </div>

      <button type="submit" disabled={loading}
        className="rounded px-4 py-2 bg-black text-white disabled:opacity-50">
        {loading ? "Guardando…" : "Registrar Pedido"}
      </button>

      {msg && <p className="text-sm">{msg}</p>}
    </form>
  );
}
