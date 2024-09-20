import mongoose from "mongoose";
import { randomUUID } from "crypto";
const sessionSchema = new mongoose.Schema({
    id: {
        type: String,
        default: randomUUID(),
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    sessionName: {
        type: String,
        default: "Untitled Session"
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
    chatHistory: [
        {
            role: {
                type: String,
                required: true,
                enum: ["user", "assistant"],
            },
            content: {
                type: String,
                required: true,
            },
            timestamp: {
                type: Date,
                default: Date.now,
            }
        }
    ]
});
const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    sessions: [
        {
            sessionId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Session"
            },
            sessionName: { type: String },
        }
    ]
});
const Session = mongoose.model("Session", sessionSchema);
const User = mongoose.model("User", userSchema);
export { User, Session };
//# sourceMappingURL=User.js.map