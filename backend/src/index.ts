import app from "./app.js"
import { connecToDatabase } from "./db/connection.js";

//connections and listeners
const PORT=process.env.PORT || 5001;
connecToDatabase().then(()=>{
  app.listen(5001,()=>console.log("Server Open and Connected to database"));
}).catch((err)=>console.log(err));


