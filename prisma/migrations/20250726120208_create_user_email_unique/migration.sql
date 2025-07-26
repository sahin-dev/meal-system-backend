/*
  Warnings:

  - A unique constraint covering the columns `[email]` on the table `mass_members` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "mass_members_email_key" ON "mass_members"("email");
