import fs from "fs";
import fetch from "node-fetch";

async function fetchProducts() {
  try {
    const res = await fetch("https://api.escuelajs.co/api/v1/products");
    const data = await res.json();
    fs.writeFileSync("./src/mocks/products.json", JSON.stringify(data, null, 2));
    console.log("✅ Datos guardados en src/mocks/products.json");
  } catch (error) {
    console.error("❌ Error al traer productos:", error);
  }
}

fetchProducts();
