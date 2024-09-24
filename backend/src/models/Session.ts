// src/models/Session.ts
import mongoose from 'mongoose';
import { randomUUID } from 'crypto';

const sessionSchema = new mongoose.Schema({
    sessionId: {
        type: mongoose.Schema.Types.ObjectId,
        //default: randomUUID(),
        ref: 'User',
        required: true
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

const Session = mongoose.model('Session', sessionSchema);
export default Session;
