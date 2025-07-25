import app from './app'
import {createServer} from 'http'
import { config } from './app/config'

const port = config.port || 5000

const server = createServer(app)


server.listen(port, ()=>{
    console.log(`server is listening on port:  ${port}`)
})

process.on("SIGINT", ()=>{
    console.log("server is closing")
    server.close()
})

process.on("SIGTERM", ()=>{
    console.log("server is closing")
    server.close()
})