import express, {NextFunction, Request, Response} from 'express'

const app = express()

app.use((req:Request, res:Response, next:NextFunction)=>{

    next(new Error("Your requested route is not supported!"))
})

app.use((err:Error, req:Request, res:Response, next:NextFunction)=>{
    console.log(err)
    res.status(500).json(err.message)

})

export default app