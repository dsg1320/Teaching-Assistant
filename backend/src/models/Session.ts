
import mongoose from 'mongoose';
import { randomUUID } from 'crypto';

const sessionSchema = new mongoose.Schema({
    sessionId: {
        type: String,
        default: randomUUID(),
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

