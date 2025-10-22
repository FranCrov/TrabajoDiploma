/*
  Warnings:

  - You are about to drop the column `apellido` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `clerkId` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `correo_electronico` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `direccion` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `dni` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `nombre` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `telefono` on the `cliente` table. All the data in the column will be lost.
  - You are about to drop the column `dirección_entrega` on the `detalle_envio` table. All the data in the column will be lost.
  - You are about to drop the column `apellido` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `clerkId` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `correo_electronico` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `direccion` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `dni` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `nombre` on the `empleado` table. All the data in the column will be lost.
  - You are about to drop the column `telefono` on the `empleado` table. All the data in the column will be lost.
  - You are about to alter the column `sueldo` on the `empleado` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `Decimal(10,2)`.
  - You are about to drop the column `id_empleadoEnvio` on the `envio` table. All the data in the column will be lost.
  - You are about to drop the `empleado_envio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `rol` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[id_usuario]` on the table `cliente` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id_usuario]` on the table `empleado` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id_prenda]` on the table `stock` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `id_usuario` to the `cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `direccion_entrega` to the `detalle_envio` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_usuario` to the `empleado` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_empleado` to the `envio` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_prenda` to the `stock` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_empleado` to the `vehiculo` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `detallefactura` DROP FOREIGN KEY `DetalleFactura_id_prenda_fkey`;

-- DropForeignKey
ALTER TABLE `detallepedido` DROP FOREIGN KEY `DetallePedido_id_prenda_fkey`;

-- DropForeignKey
ALTER TABLE `empleado_envio` DROP FOREIGN KEY `Empleado_Envio_id_empleado_fkey`;

-- DropForeignKey
ALTER TABLE `empleado_envio` DROP FOREIGN KEY `Empleado_Envio_id_rol_fkey`;

-- DropForeignKey
ALTER TABLE `envio` DROP FOREIGN KEY `Envio_id_cliente_fkey`;

-- DropForeignKey
ALTER TABLE `envio` DROP FOREIGN KEY `Envio_id_detalleEnvio_fkey`;

-- DropForeignKey
ALTER TABLE `envio` DROP FOREIGN KEY `Envio_id_empleadoEnvio_fkey`;

-- DropForeignKey
ALTER TABLE `envio` DROP FOREIGN KEY `Envio_id_pedido_fkey`;

-- DropForeignKey
ALTER TABLE `envio` DROP FOREIGN KEY `Envio_id_vehiculo_fkey`;

-- DropForeignKey
ALTER TABLE `factura` DROP FOREIGN KEY `Factura_id_detalleFactura_fkey`;

-- DropForeignKey
ALTER TABLE `factura` DROP FOREIGN KEY `Factura_id_pedido_fkey`;

-- DropForeignKey
ALTER TABLE `notificacion` DROP FOREIGN KEY `Notificacion_id_cliente_fkey`;

-- DropForeignKey
ALTER TABLE `notificacion` DROP FOREIGN KEY `Notificacion_id_pedido_fkey`;

-- DropForeignKey
ALTER TABLE `pedido` DROP FOREIGN KEY `Pedido_id_cliente_fkey`;

-- DropForeignKey
ALTER TABLE `pedido` DROP FOREIGN KEY `Pedido_id_detallePedido_fkey`;

-- DropForeignKey
ALTER TABLE `pedido` DROP FOREIGN KEY `Pedido_id_empresa_fkey`;

-- DropForeignKey
ALTER TABLE `prenda` DROP FOREIGN KEY `Prenda_id_empresa_fkey`;

-- DropForeignKey
ALTER TABLE `reclamo` DROP FOREIGN KEY `Reclamo_id_cliente_fkey`;

-- DropForeignKey
ALTER TABLE `reclamo` DROP FOREIGN KEY `Reclamo_id_pedido_fkey`;

-- DropForeignKey
ALTER TABLE `vehiculo` DROP FOREIGN KEY `Vehiculo_id_mantenimiento_fkey`;

-- DropIndex
DROP INDEX `Cliente_clerkId_key` ON `cliente`;

-- DropIndex
DROP INDEX `Cliente_correo_electronico_key` ON `cliente`;

-- DropIndex
DROP INDEX `Empleado_clerkId_key` ON `empleado`;

-- DropIndex
DROP INDEX `Empleado_correo_electronico_key` ON `empleado`;

-- DropIndex
DROP INDEX `Envio_id_empleadoEnvio_fkey` ON `envio`;

-- AlterTable
ALTER TABLE `cliente` DROP COLUMN `apellido`,
    DROP COLUMN `clerkId`,
    DROP COLUMN `correo_electronico`,
    DROP COLUMN `direccion`,
    DROP COLUMN `dni`,
    DROP COLUMN `nombre`,
    DROP COLUMN `telefono`,
    ADD COLUMN `id_usuario` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `detalle_envio` DROP COLUMN `dirección_entrega`,
    ADD COLUMN `direccion_entrega` VARCHAR(100) NOT NULL;

-- AlterTable
ALTER TABLE `empleado` DROP COLUMN `apellido`,
    DROP COLUMN `clerkId`,
    DROP COLUMN `correo_electronico`,
    DROP COLUMN `direccion`,
    DROP COLUMN `dni`,
    DROP COLUMN `nombre`,
    DROP COLUMN `telefono`,
    ADD COLUMN `disponible` BOOLEAN NULL DEFAULT true,
    ADD COLUMN `id_usuario` INTEGER NOT NULL,
    MODIFY `sueldo` DECIMAL(10, 2) NULL;

-- AlterTable
ALTER TABLE `envio` DROP COLUMN `id_empleadoEnvio`,
    ADD COLUMN `id_empleado` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `stock` ADD COLUMN `id_prenda` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `vehiculo` ADD COLUMN `id_empleado` INTEGER NOT NULL;

-- DropTable
DROP TABLE `empleado_envio`;

-- DropTable
DROP TABLE `rol`;

-- CreateTable
CREATE TABLE `usuario` (
    `id_usuario` INTEGER NOT NULL AUTO_INCREMENT,
    `clerkId` VARCHAR(191) NULL,
    `nombre` VARCHAR(30) NOT NULL,
    `apellido` VARCHAR(30) NULL,
    `direccion` VARCHAR(100) NULL,
    `correo_electronico` VARCHAR(100) NOT NULL,
    `telefono` INTEGER NULL,
    `dni` INTEGER NULL,

    UNIQUE INDEX `usuario_clerkId_key`(`clerkId`),
    UNIQUE INDEX `usuario_correo_electronico_key`(`correo_electronico`),
    PRIMARY KEY (`id_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grupo` (
    `id_grupo` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `descripcion` VARCHAR(100) NULL,

    PRIMARY KEY (`id_grupo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `accion` (
    `id_accion` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `descripcion` VARCHAR(100) NULL,

    PRIMARY KEY (`id_accion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grupo_accion` (
    `id_grupo_accion` INTEGER NOT NULL AUTO_INCREMENT,
    `id_grupo` INTEGER NOT NULL,
    `id_accion` INTEGER NOT NULL,

    INDEX `grupo_accion_id_grupo_idx`(`id_grupo`),
    INDEX `grupo_accion_id_accion_idx`(`id_accion`),
    PRIMARY KEY (`id_grupo_accion`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `grupo_usuario` (
    `id_grupo_usuario` INTEGER NOT NULL AUTO_INCREMENT,
    `id_usuario` INTEGER NOT NULL,
    `id_grupo` INTEGER NOT NULL,

    INDEX `grupo_usuario_id_usuario_idx`(`id_usuario`),
    INDEX `grupo_usuario_id_grupo_idx`(`id_grupo`),
    PRIMARY KEY (`id_grupo_usuario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `cliente_id_usuario_key` ON `cliente`(`id_usuario`);

-- CreateIndex
CREATE UNIQUE INDEX `empleado_id_usuario_key` ON `empleado`(`id_usuario`);

-- CreateIndex
CREATE INDEX `envio_id_empleado_idx` ON `envio`(`id_empleado`);

-- CreateIndex
CREATE UNIQUE INDEX `stock_id_prenda_key` ON `stock`(`id_prenda`);

-- CreateIndex
CREATE INDEX `vehiculo_id_empleado_idx` ON `vehiculo`(`id_empleado`);

-- AddForeignKey
ALTER TABLE `grupo_accion` ADD CONSTRAINT `grupo_accion_id_grupo_fkey` FOREIGN KEY (`id_grupo`) REFERENCES `grupo`(`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `grupo_accion` ADD CONSTRAINT `grupo_accion_id_accion_fkey` FOREIGN KEY (`id_accion`) REFERENCES `accion`(`id_accion`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `grupo_usuario` ADD CONSTRAINT `grupo_usuario_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `grupo_usuario` ADD CONSTRAINT `grupo_usuario_id_grupo_fkey` FOREIGN KEY (`id_grupo`) REFERENCES `grupo`(`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `empleado` ADD CONSTRAINT `empleado_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `cliente` ADD CONSTRAINT `cliente_id_usuario_fkey` FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vehiculo` ADD CONSTRAINT `vehiculo_id_mantenimiento_fkey` FOREIGN KEY (`id_mantenimiento`) REFERENCES `mantenimiento`(`id_mantenimiento`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vehiculo` ADD CONSTRAINT `vehiculo_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `empleado`(`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `envio` ADD CONSTRAINT `envio_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `envio` ADD CONSTRAINT `envio_id_detalleEnvio_fkey` FOREIGN KEY (`id_detalleEnvio`) REFERENCES `detalle_envio`(`id_detalleEnvio`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `envio` ADD CONSTRAINT `envio_id_empleado_fkey` FOREIGN KEY (`id_empleado`) REFERENCES `empleado`(`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `envio` ADD CONSTRAINT `envio_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `envio` ADD CONSTRAINT `envio_id_vehiculo_fkey` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculo`(`id_vehiculo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_id_detallePedido_fkey` FOREIGN KEY (`id_detallePedido`) REFERENCES `detallepedido`(`id_detallePedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_id_empresa_fkey` FOREIGN KEY (`id_empresa`) REFERENCES `empresa`(`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detallepedido` ADD CONSTRAINT `detallepedido_id_prenda_fkey` FOREIGN KEY (`id_prenda`) REFERENCES `prenda`(`id_prenda`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `factura` ADD CONSTRAINT `factura_id_detalleFactura_fkey` FOREIGN KEY (`id_detalleFactura`) REFERENCES `detallefactura`(`id_detalleFactura`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `factura` ADD CONSTRAINT `factura_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detallefactura` ADD CONSTRAINT `detallefactura_id_prenda_fkey` FOREIGN KEY (`id_prenda`) REFERENCES `prenda`(`id_prenda`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `prenda` ADD CONSTRAINT `prenda_id_empresa_fkey` FOREIGN KEY (`id_empresa`) REFERENCES `empresa`(`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stock` ADD CONSTRAINT `stock_id_prenda_fkey` FOREIGN KEY (`id_prenda`) REFERENCES `prenda`(`id_prenda`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `notificacion` ADD CONSTRAINT `notificacion_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `notificacion` ADD CONSTRAINT `notificacion_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reclamo` ADD CONSTRAINT `reclamo_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reclamo` ADD CONSTRAINT `reclamo_id_pedido_fkey` FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `detallefactura` RENAME INDEX `DetalleFactura_id_prenda_fkey` TO `detallefactura_id_prenda_idx`;

-- RenameIndex
ALTER TABLE `detallepedido` RENAME INDEX `DetallePedido_id_prenda_fkey` TO `detallepedido_id_prenda_idx`;

-- RenameIndex
ALTER TABLE `envio` RENAME INDEX `Envio_id_cliente_fkey` TO `envio_id_cliente_idx`;

-- RenameIndex
ALTER TABLE `envio` RENAME INDEX `Envio_id_detalleEnvio_fkey` TO `envio_id_detalleEnvio_idx`;

-- RenameIndex
ALTER TABLE `envio` RENAME INDEX `Envio_id_pedido_fkey` TO `envio_id_pedido_idx`;

-- RenameIndex
ALTER TABLE `envio` RENAME INDEX `Envio_id_vehiculo_fkey` TO `envio_id_vehiculo_idx`;

-- RenameIndex
ALTER TABLE `factura` RENAME INDEX `Factura_id_detalleFactura_fkey` TO `factura_id_detalleFactura_idx`;

-- RenameIndex
ALTER TABLE `factura` RENAME INDEX `Factura_id_pedido_fkey` TO `factura_id_pedido_idx`;

-- RenameIndex
ALTER TABLE `notificacion` RENAME INDEX `Notificacion_id_cliente_fkey` TO `notificacion_id_cliente_idx`;

-- RenameIndex
ALTER TABLE `notificacion` RENAME INDEX `Notificacion_id_pedido_fkey` TO `notificacion_id_pedido_idx`;

-- RenameIndex
ALTER TABLE `pedido` RENAME INDEX `Pedido_id_cliente_fkey` TO `pedido_id_cliente_idx`;

-- RenameIndex
ALTER TABLE `pedido` RENAME INDEX `Pedido_id_detallePedido_fkey` TO `pedido_id_detallePedido_idx`;

-- RenameIndex
ALTER TABLE `pedido` RENAME INDEX `Pedido_id_empresa_fkey` TO `pedido_id_empresa_idx`;

-- RenameIndex
ALTER TABLE `prenda` RENAME INDEX `Prenda_id_empresa_fkey` TO `prenda_id_empresa_idx`;

-- RenameIndex
ALTER TABLE `reclamo` RENAME INDEX `Reclamo_id_cliente_fkey` TO `reclamo_id_cliente_idx`;

-- RenameIndex
ALTER TABLE `reclamo` RENAME INDEX `Reclamo_id_pedido_fkey` TO `reclamo_id_pedido_idx`;

-- RenameIndex
ALTER TABLE `vehiculo` RENAME INDEX `Vehiculo_id_mantenimiento_fkey` TO `vehiculo_id_mantenimiento_idx`;
