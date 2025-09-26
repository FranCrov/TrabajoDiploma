/*
  Warnings:

  - You are about to alter the column `sueldo` on the `empleado` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,2)` to `Decimal(65,30)`.

*/
-- AlterTable
ALTER TABLE `cliente` MODIFY `dni` INTEGER NULL,
    MODIFY `telefono` INTEGER NULL;

-- AlterTable
ALTER TABLE `empleado` MODIFY `telefono` INTEGER NULL,
    MODIFY `dni` INTEGER NULL,
    MODIFY `sueldo` DECIMAL(65, 30) NULL;
