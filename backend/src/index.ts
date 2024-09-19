import app from "./app.js"
import { connecToDatabase } from "./db/connection.js";

//connections and listeners
const PORT=process.env.PORT || 5000;
connecToDatabase().then(()=>{
  app.listen(5000,()=>console.log("Server Open and Connected to database"));
}).catch((err)=>console.log(err));


