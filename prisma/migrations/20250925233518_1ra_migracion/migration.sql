-- CreateTable
CREATE TABLE `Cliente` (
    `id_cliente` INTEGER NOT NULL AUTO_INCREMENT,
    `clerkId` VARCHAR(191) NULL,
    `nombre` VARCHAR(30) NOT NULL,
    `dni` INTEGER NOT NULL,
    `direccion` VARCHAR(100) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,
    `telefono` INTEGER NOT NULL,

    UNIQUE INDEX `Cliente_clerkId_key`(`clerkId`),
    UNIQUE INDEX `Cliente_correo_electronico_key`(`correo_electronico`),
    PRIMARY KEY (`id_cliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Empleado` (
    `id_empleado` INTEGER NOT NULL AUTO_INCREMENT,
    `clerkId` VARCHAR(191) NULL,
    `nombre` VARCHAR(30) NOT NULL,
    `apellido` VARCHAR(30) NOT NULL,
    `direccion` VARCHAR(100) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,
    `telefono` INTEGER NOT NULL,
    `dni` INTEGER NOT NULL,
    `sueldo` DECIMAL(10, 2) NOT NULL,

    UNIQUE INDEX `Empleado_clerkId_key`(`clerkId`),
    UNIQUE INDEX `Empleado_correo_electronico_key`(`correo_electronico`),
    PRIMARY KEY (`id_empleado`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Empleado_Envio` (
    `id_empleadoEnvio` INTEGER NOT NULL AUTO_INCREMENT,
    `id_empleado` INTEGER NOT NULL,
    `id_rol` INTEGER NOT NULL,

    PRIMARY KEY (`id_empleadoEnvio`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Envio` (
    `id_envio` INTEGER NOT NULL AUTO_INCREMENT,
    `id_empleadoEnvio` INTEGER NOT NULL,
    `id_pedido` INTEGER NOT NULL,
    `id_vehiculo` INTEGER NOT NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_detalleEnvio` INTEGER NOT NULL,
    `estado` VARCHAR(100) NOT NULL,
    `fecha_despacho` DATE NOT NULL,

    PRIMARY KEY (`id_envio`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Detalle_envio` (
    `id_detalleEnvio` INTEGER NOT NULL AUTO_INCREMENT,
    `costo_total` DECIMAL(10, 2) NOT NULL,
    `distancia` DECIMAL(10, 2) NOT NULL,
    `fecha_despacho` DATE NOT NULL,
    `dirección_entrega` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_detalleEnvio`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notificacion` (
    `id_notificacion` INTEGER NOT NULL AUTO_INCREMENT,
    `id_cliente` INTEGER NOT NULL,
    `id_pedido` INTEGER NOT NULL,
    `fecha_envio` DATETIME(0) NOT NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_notificacion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Rol` (
    `id_rol` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `descripcion` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_rol`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Vehiculo` (
    `id_vehiculo` INTEGER NOT NULL AUTO_INCREMENT,
    `id_mantenimiento` INTEGER NOT NULL,
    `modelo` VARCHAR(100) NOT NULL,
    `capacidad_peso` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id_vehiculo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Pedido` (
    `id_pedido` INTEGER NOT NULL AUTO_INCREMENT,
    `id_cliente` INTEGER NOT NULL,
    `id_detallePedido` INTEGER NOT NULL,
    `id_empresa` INTEGER NOT NULL,
    `estado` VARCHAR(100) NOT NULL,
    `fecha_pedido` DATE NOT NULL,
    `cantidad` INTEGER NOT NULL,

    PRIMARY KEY (`id_pedido`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Prenda` (
    `id_prenda` INTEGER NOT NULL AUTO_INCREMENT,
    `id_empresa` INTEGER NOT NULL,
    `tipo` VARCHAR(30) NOT NULL,
    `talla` VARCHAR(30) NOT NULL,
    `color` VARCHAR(30) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id_prenda`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Stock` (
    `id_stock` INTEGER NOT NULL AUTO_INCREMENT,
    `cantidadDisponible` INTEGER NOT NULL,
    `stockMinimo` INTEGER NOT NULL,
    `stockMaximo` INTEGER NOT NULL,
    `fechaUltimaReposicion` DATE NOT NULL,

    PRIMARY KEY (`id_stock`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Mantenimiento` (
    `id_mantenimiento` INTEGER NOT NULL AUTO_INCREMENT,
    `tipo` VARCHAR(30) NOT NULL,
    `fecha` DATE NOT NULL,
    `costo` DECIMAL(10, 2) NOT NULL,
    `descripcion` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_mantenimiento`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DetallePedido` (
    `id_detallePedido` INTEGER NOT NULL AUTO_INCREMENT,
    `id_prenda` INTEGER NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `precio_unitario` DECIMAL(10, 2) NOT NULL,
    `sub_total` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id_detallePedido`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Factura` (
    `id_factura` INTEGER NOT NULL AUTO_INCREMENT,
    `id_detalleFactura` INTEGER NOT NULL,
    `id_pedido` INTEGER NOT NULL,
    `fecha_emision` DATE NOT NULL,
    `metodo_pago` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`id_factura`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Empresa` (
    `id_empresa` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(30) NOT NULL,
    `direccion` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_empresa`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DetalleFactura` (
    `id_detalleFactura` INTEGER NOT NULL AUTO_INCREMENT,
    `id_prenda` INTEGER NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `precio_unitario` DECIMAL(10, 2) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id_detalleFactura`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Reclamo` (
    `id_reclamo` INTEGER NOT NULL AUTO_INCREMENT,
    `id_cliente` INTEGER NOT NULL,
    `id_pedido` INTEGER NOT NULL,
    `descripcion` VARCHAR(100) NOT NULL,
    `fecha` DATE NOT NULL,
    `estado` VARCHAR(30) NOT NULL,

    PRIMARY KEY (`id_reclamo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Empleado_Envio` ADD CONSTRAINT `Empleado_Envio_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `Empleado`(`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Empleado_Envio` ADD CONSTRAINT `Empleado_Envio_id_rol_fkey` FOREIGN KEY (`id_rol`) REFERENCES `Rol`(`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Envio` ADD CONSTRAINT `Envio_id_empleadoEnvio_fkey` FOREIGN KEY (`id_empleadoEnvio`) REFERENCES `Empleado_Envio`(`id_empleadoEnvio`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Envio` ADD CONSTRAINT `Envio_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Envio` ADD CONSTRAINT `Envio_id_vehiculo_fkey` FOREIGN KEY (`id_vehiculo`) REFERENCES `Vehiculo`(`id_vehiculo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Envio` ADD CONSTRAINT `Envio_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Envio` ADD CONSTRAINT `Envio_id_detalleEnvio_fkey` FOREIGN KEY (`id_detalleEnvio`) REFERENCES `Detalle_envio`(`id_detalleEnvio`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notificacion` ADD CONSTRAINT `Notificacion_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notificacion` ADD CONSTRAINT `Notificacion_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Vehiculo` ADD CONSTRAINT `Vehiculo_id_mantenimiento_fkey` FOREIGN KEY (`id_mantenimiento`) REFERENCES `Mantenimiento`(`id_mantenimiento`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pedido` ADD CONSTRAINT `Pedido_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pedido` ADD CONSTRAINT `Pedido_id_detallePedido_fkey` FOREIGN KEY (`id_detallePedido`) REFERENCES `DetallePedido`(`id_detallePedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pedido` ADD CONSTRAINT `Pedido_id_empresa_fkey` FOREIGN KEY (`id_empresa`) REFERENCES `Empresa`(`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Prenda` ADD CONSTRAINT `Prenda_id_empresa_fkey` FOREIGN KEY (`id_empresa`) REFERENCES `Empresa`(`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetallePedido` ADD CONSTRAINT `DetallePedido_id_prenda_fkey` FOREIGN KEY (`id_prenda`) REFERENCES `Prenda`(`id_prenda`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Factura` ADD CONSTRAINT `Factura_id_detalleFactura_fkey` FOREIGN KEY (`id_detalleFactura`) REFERENCES `DetalleFactura`(`id_detalleFactura`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Factura` ADD CONSTRAINT `Factura_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DetalleFactura` ADD CONSTRAINT `DetalleFactura_id_prenda_fkey` FOREIGN KEY (`id_prenda`) REFERENCES `Prenda`(`id_prenda`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reclamo` ADD CONSTRAINT `Reclamo_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Reclamo` ADD CONSTRAINT `Reclamo_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;
