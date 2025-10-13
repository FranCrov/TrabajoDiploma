"use client";

import Image from "next/image";
import { Montserrat } from "next/font/google";
import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useUser } from "@clerk/nextjs";

const montserrat = Montserrat({ subsets: ["latin"], weight: ["400","500","700"] });

export default function Home() {
  const router = useRouter();
  const { isSignedIn, isLoaded } = useUser();

  useEffect(() => {
    if (isLoaded && isSignedIn) {
      router.replace("/client"); // redirige al cliente si está logueado
    }
  }, [isLoaded, isSignedIn, router]);

  if (!isLoaded || isSignedIn) return null;

  return (
    <div
      className={`min-h-screen w-full flex flex-col items-center justify-start bg-gradient-to-b from-cyan-400 via-blue-500 to-blue-800 ${montserrat.className} overflow-hidden`}
    >
      <div className="mt-20 sm:mt-32"></div>

      <Image
        src="/Logo_PNG_3.png"
        alt="Logo Smartcloth"
        width={500}
        height={500}
        className="object-contain"
      />

      <div className="mt-12 sm:mt-16"></div>

      <p className="text-4xl sm:text-5xl font-semibold text-white text-center drop-shadow-lg">
        Confianza y precisión en cada envío
      </p>

      <div className="mt-12 sm:mt-16"></div>

      <p className="text-3xl sm:text-4xl font-medium text-white/90 text-center max-w-lg drop-shadow-md">
        Por favor, inicie sesión para comenzar
      </p>

      <div className="mb-20 sm:mb-32"></div>
    </div>
  );
}
