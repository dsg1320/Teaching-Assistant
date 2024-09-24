import mongoose, { isValidObjectId } from "mongoose";
//import { randomUUID } from "crypto";


const userSchema = new mongoose.Schema({
    username:{
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password:{
        type:String,
        required: true,
    },
    sessions: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Session', // Reference the Session model
        }
    ]
});


const User = mongoose.model("User", userSchema);

//export {User};
export default User;