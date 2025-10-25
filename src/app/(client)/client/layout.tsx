"use client";

import { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  const [showCatalog, setShowCatalog] = useState(false);
  const pathname = usePathname();

  const isActive = (path: string) => pathname === path;

  return (
    <div className="flex min-h-screen bg-gray-50">
      {/* Sidebar */}
      <aside className="w-64 bg-blue-700 text-white flex flex-col justify-between">
        <div>
          {/* Logo */}
          <div className="p-4 border-b border-blue-500">
            <Link href="/client" className="flex items-center gap-2">
              <img src="/Logo_PNG_3.png" alt="Logo" className="w-8 h-8" />
              <span className="text-lg font-bold">Smartcloth</span>
            </Link>
          </div>

          {/* Menú */}
          <nav className="p-4 space-y-3">
            <button
              onClick={() => setShowCatalog(!showCatalog)}
              className={`w-full text-left hover:text-blue-200 ${
                pathname.startsWith("/client/catalogo") ? "text-blue-200 font-bold" : ""
              }`}
            >
              📂 Catálogo
            </button>

            {showCatalog && (
              <div className="ml-4 space-y-2">
                <Link
                  href="/client/catalogo/buzos"
                  className={`block hover:text-blue-200 ${
                    isActive("/client/catalogo/buzos") ? "text-blue-300 font-bold" : ""
                  }`}
                >
                  • Buzos
                </Link>
                <Link
                  href="/client/catalogo/zapatillas"
                  className={`block hover:text-blue-200 ${
                    isActive("/client/catalogo/zapatillas") ? "text-blue-300 font-bold" : ""
                  }`}
                >
                  • Zapatillas
                </Link>
              </div>
            )}

            <Link
              href="/client/pedidos"
              className={`block hover:text-blue-200 ${
                isActive("/client/pedidos") ? "text-blue-300 font-bold" : ""
              }`}
            >
              📦 Mis pedidos
            </Link>

            <Link
              href="/client/devoluciones"
              className={`block hover:text-blue-200 ${
                isActive("/client/devoluciones") ? "text-blue-300 font-bold" : ""
              }`}
            >
              ↩️ Devoluciones
            </Link>
          </nav>
        </div>

        {/* Help abajo */}
        <div className="p-4 border-t border-blue-500">
          <Link
            href="/client/help"
            className={`block hover:text-blue-200 ${
              isActive("/client/help") ? "text-blue-300 font-bold" : ""
            }`}
          >
            ❓ Help
          </Link>
        </div>
      </aside>

      {/* Contenido principal */}
      <main className="flex-1 p-6 overflow-y-auto">{children}</main>
    </div>
  );
}
