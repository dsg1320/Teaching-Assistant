
import mongoose from 'mongoose';
import { randomUUID } from 'crypto';

const sessionSchema = new mongoose.Schema({
    userId: {
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
            },
            accuracy: {
                type: Number
            },
            complexity: {
                type: String,
                enum: ["easy", "moderate", "difficult"],
                required: true
            },
        },
    ],
    performanceScore: {
        type: Number,
        default: 0
    },
    topicScores: {
        type: Map,
        of: Number, // Specify the type of values in the Map
        default: {}
    }
});

const Session = mongoose.model('Session', sessionSchema);
export default Session;

