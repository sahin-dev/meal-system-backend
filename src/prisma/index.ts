
import e from "express";
import { PrismaClient } from "../generated/prisma";


let client = new PrismaClient()
export default client