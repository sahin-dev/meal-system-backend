-- CreateEnum
CREATE TYPE "USERROLE" AS ENUM ('MEMBER', 'MANAGER', 'SUPERADMIN');

-- CreateEnum
CREATE TYPE "MealStatus" AS ENUM ('ACCEPTED', 'DECLINED');

-- CreateEnum
CREATE TYPE "RequirementStatus" AS ENUM ('RESOLVED', 'PENDING');

-- CreateEnum
CREATE TYPE "MealType" AS ENUM ('BREAKFAST', 'LAUNCH', 'DINNER');

-- CreateTable
CREATE TABLE "caterings" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "caterings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "memberId" INTEGER NOT NULL,
    "cateringId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "masses" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "managerId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "masses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "requests" (
    "id" SERIAL NOT NULL,
    "memberId" TEXT NOT NULL,
    "catringId" TEXT NOT NULL,
    "status" "MealStatus" NOT NULL,
    "type" "MealType" NOT NULL,
    "remark" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mass_members" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "massId" INTEGER,
    "cateringId" INTEGER,
    "role" "USERROLE"[] DEFAULT ARRAY['MEMBER']::"USERROLE"[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mass_members_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meals" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantity" INTEGER NOT NULL,
    "type" "MealType" NOT NULL,
    "memberId" INTEGER NOT NULL,
    "massId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "meals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "requirements" (
    "id" SERIAL NOT NULL,
    "massId" INTEGER NOT NULL,
    "memberId" INTEGER NOT NULL,
    "text" TEXT NOT NULL,
    "status" "RequirementStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "requirements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notices" (
    "id" SERIAL NOT NULL,
    "text" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "notices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shoppings" (
    "id" SERIAL NOT NULL,
    "ingredients" TEXT[],
    "price" DECIMAL(65,30) NOT NULL,
    "memberId" INTEGER NOT NULL,
    "massId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "shoppings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CateringToMemebr" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_CateringToMemebr_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "masses_managerId_key" ON "masses"("managerId");

-- CreateIndex
CREATE INDEX "_CateringToMemebr_B_index" ON "_CateringToMemebr"("B");

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_cateringId_fkey" FOREIGN KEY ("cateringId") REFERENCES "caterings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "masses" ADD CONSTRAINT "masses_managerId_fkey" FOREIGN KEY ("managerId") REFERENCES "mass_members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mass_members" ADD CONSTRAINT "mass_members_massId_fkey" FOREIGN KEY ("massId") REFERENCES "masses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meals" ADD CONSTRAINT "meals_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "mass_members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meals" ADD CONSTRAINT "meals_massId_fkey" FOREIGN KEY ("massId") REFERENCES "masses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requirements" ADD CONSTRAINT "requirements_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "mass_members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requirements" ADD CONSTRAINT "requirements_massId_fkey" FOREIGN KEY ("massId") REFERENCES "masses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shoppings" ADD CONSTRAINT "shoppings_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "mass_members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shoppings" ADD CONSTRAINT "shoppings_massId_fkey" FOREIGN KEY ("massId") REFERENCES "masses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CateringToMemebr" ADD CONSTRAINT "_CateringToMemebr_A_fkey" FOREIGN KEY ("A") REFERENCES "caterings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CateringToMemebr" ADD CONSTRAINT "_CateringToMemebr_B_fkey" FOREIGN KEY ("B") REFERENCES "mass_members"("id") ON DELETE CASCADE ON UPDATE CASCADE;
