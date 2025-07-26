import prisma from '../../../prisma'
import { IMass } from "./mass.interface";


const createMass = async(massData:IMass)=>{

    const createdMass = await prisma.mass.create({data:{name:massData.name, managerId:massData.creatorId}})

    return createdMass

}

export const massService =  {
    createMass
}