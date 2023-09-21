-- CreateEnum
CREATE TYPE "Mentor_Role" AS ENUM ('INDIVIDUAL', 'COLLEGE_REPRESENTATIVE', 'TRUST_REPRESENTATIVE', 'NGO_REPRESENTATIVE', 'ADMIN');

-- CreateEnum
CREATE TYPE "Student_Role" AS ENUM ('COLLEGE_Student', 'SCHOOL_Student', 'SELF_Student');

-- CreateEnum
CREATE TYPE "Institution_Type" AS ENUM ('COLLEGE', 'SCHOOL', 'NGO', 'TRUST');

-- CreateEnum
CREATE TYPE "Support_Type" AS ENUM ('loan', 'Fund', 'Scheme');

-- CreateEnum
CREATE TYPE "Resource_Type" AS ENUM ('PDF_URL', 'VIDEO_TUTORIAL', 'WEB_URL', 'OTHERS');

-- CreateTable
CREATE TABLE "Mentor" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "Mentor_Role" NOT NULL DEFAULT 'INDIVIDUAL',
    "Description" TEXT,
    "password" TEXT,
    "contact" TEXT NOT NULL,
    "location" TEXT[],
    "institutionId" INTEGER,
    "proof" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Mentor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Student" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "Student_Role" NOT NULL DEFAULT 'SELF_Student',
    "description" TEXT,
    "password" TEXT,
    "contact" TEXT,
    "location" TEXT[],
    "proof" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "following" TEXT[],
    "saved" TEXT[],

    CONSTRAINT "Student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Institution" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "type" "Institution_Type" NOT NULL DEFAULT 'COLLEGE',
    "description" TEXT,
    "password" TEXT,
    "contact" TEXT,
    "location" TEXT[],
    "proof" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Institution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Support" (
    "id" SERIAL NOT NULL,
    "mentorId" INTEGER,
    "title" TEXT NOT NULL,
    "type" "Support_Type" NOT NULL DEFAULT 'Fund',
    "description" TEXT,
    "criteria" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "LastAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Support_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Resource" (
    "id" SERIAL NOT NULL,
    "mentorId" INTEGER,
    "title" TEXT NOT NULL,
    "type" "Resource_Type" NOT NULL DEFAULT 'PDF_URL',
    "description" TEXT,
    "body" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Resource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FlashNews" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "body" TEXT NOT NULL,
    "link" TEXT,
    "mentorId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FlashNews_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkShop" (
    "id" SERIAL NOT NULL,
    "mentorId" INTEGER,
    "title" TEXT NOT NULL,
    "type" "Support_Type" NOT NULL DEFAULT 'Fund',
    "description" TEXT,
    "body" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkShop_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Mentor_email_key" ON "Mentor"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Student_email_key" ON "Student"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Institution_email_key" ON "Institution"("email");

-- AddForeignKey
ALTER TABLE "Mentor" ADD CONSTRAINT "Mentor_institutionId_fkey" FOREIGN KEY ("institutionId") REFERENCES "Institution"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support" ADD CONSTRAINT "Support_mentorId_fkey" FOREIGN KEY ("mentorId") REFERENCES "Mentor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resource" ADD CONSTRAINT "Resource_mentorId_fkey" FOREIGN KEY ("mentorId") REFERENCES "Mentor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlashNews" ADD CONSTRAINT "FlashNews_mentorId_fkey" FOREIGN KEY ("mentorId") REFERENCES "Mentor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkShop" ADD CONSTRAINT "WorkShop_mentorId_fkey" FOREIGN KEY ("mentorId") REFERENCES "Mentor"("id") ON DELETE SET NULL ON UPDATE CASCADE;
