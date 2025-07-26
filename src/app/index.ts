import express, {NextFunction, Request, Response} from 'express'
import morgan from 'morgan'
import responseTime from 'response-time'

const app = express()

app.use(responseTime())
app.use(morgan("dev"))

app.get("/",(req:Request, res:Response)=>{
    res.send(`${req.method.toUpperCase()}: ${req.url}`)

})

app.use((req:Request, res:Response, next:NextFunction)=>{

    next(new Error("Your requested route is not supported!"))
})

app.use((err:Error, req:Request, res:Response, next:NextFunction)=>{
    console.log(err)
    res.status(500).json(err.message)

})

export default app