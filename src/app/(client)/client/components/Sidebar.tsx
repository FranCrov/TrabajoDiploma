"use client";

import { useState } from "react";
import Link from "next/link";

export default function Sidebar() {
  const [showCatalog, setShowCatalog] = useState(false);

  return (
    <div className="w-64 bg-blue-700 text-white flex flex-col justify-between">
      {/* LOGO */}
      <div>
        <div className="p-4 border-b border-blue-500">
          <Link href="/client" className="flex items-center gap-2">
            <img src="/logo.png" alt="Logo" className="w-8 h-8" />
            <span className="text-lg font-bold">Smartcloth</span>
          </Link>
        </div>

        {/* MENÚ PRINCIPAL */}
        <nav className="p-4 space-y-3">
          <button
            onClick={() => setShowCatalog(!showCatalog)}
            className="w-full text-left hover:text-blue-200"
          >
            📂 Catálogo
          </button>

          {showCatalog && (
            <div className="ml-4 space-y-2">
              <Link href="/client/catalogo/buzos" className="block hover:text-blue-200">
                • Buzos
              </Link>
              <Link href="/client/catalogo/zapatillas" className="block hover:text-blue-200">
                • Zapatillas
              </Link>
            </div>
          )}

          <Link href="/client/pedidos" className="block hover:text-blue-200">
            📦 Mis pedidos
          </Link>

          <Link href="/client/devoluciones" className="block hover:text-blue-200">
            ↩️ Devoluciones
          </Link>
        </nav>
      </div>

      {/* SECCIÓN INFERIOR */}
      <div className="p-4 border-t border-blue-500">
        <Link href="/client/help" className="block hover:text-blue-200">
          ❓ Help
        </Link>
      </div>
    </div>
  );
}
