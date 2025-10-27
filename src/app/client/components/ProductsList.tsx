import products from "../../../../src/mocks/products.json";

export default function ProductsList() {
  return (
    <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "20px" }}>
      {products.map((product) => (
        <div key={product.id} style={{ border: "1px solid #ccc", padding: "10px" }}>
          <h3>{product.title}</h3>
          <img src={product.images[0]} alt={product.title} width={150} />
          <p>${product.price}</p>
        </div>
      ))}
    </div>
  );
}
