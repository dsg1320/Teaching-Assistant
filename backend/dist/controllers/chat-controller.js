import { generateSocraticResponse } from '../utils/assistant-helper.js';
//import User from '../models/Users.js';
import Session from '../models/Session.js'; // Import Session model
//import { calculateComplexity } from '../utils/topic-helper.js';
const allowedComplexities = ["easy", "moderate", "difficult"];
// Function to calculate complexity
const calculateComplexity = (message) => {
    if (message.includes('bubble sort'))
        return 'easy';
    if (message.includes('merge sort'))
        return 'moderate';
    if (message.includes('heap sort'))
        return 'difficult';
    return null;
};
export const handleChat = async (req, res) => {
    try {
        const { sessionId, message } = req.body;
        // Find the session by its ID
        const session = await Session.findById(sessionId);
        if (!session) {
            return res.status(404).json({ error: 'Session not found' });
        }
        const complexity = await calculateComplexity(message) || 'easy';
        // Append the user's message to the session history
        session.chatHistory.push({
            role: "user",
            content: message,
            timestamp: new Date(),
            complexity: complexity,
        });
        //console.log(session.chatHistory)
        const formattedChatHistory = session.chatHistory.map((msg) => ({
            role: msg.role === 'user' ? "user" : "model",
            parts: [{ text: msg.content }]
        }));
        //console.log("Chat History Before Sending:", JSON.stringify(formattedChatHistory, null, 2));
        if (formattedChatHistory.length === 0) {
            return res.status(400).json({ error: 'Chat history is empty.' });
        }
        for (const msg of formattedChatHistory) {
            if (!msg.role || !msg.parts || !msg.parts[0].text) {
                return res.status(400).json({ error: 'Chat history is missing required fields.' });
            }
        }
        // Generate the response from Gemini AI
        const assistantMessage = await generateSocraticResponse(formattedChatHistory);
        const assistantComplexity = await calculateComplexity(assistantMessage) || 'easy';
        // Append the assistant's response to the session history
        session.chatHistory.push({
            role: "assistant",
            content: assistantMessage,
            timestamp: new Date(),
            complexity: assistantComplexity,
        });
        // Save the updated session
        await session.save();
        // Send the assistant's response back to the frontend
        res.json({ message: assistantMessage });
    }
    catch (error) {
        console.error('Error handling chat:', error);
        res.status(500).json({ error: 'Failed to generate response' });
    }
};
//# sourceMappingURL=chat-controller.js.map
//# sourceMappingURL=chat-controller.js.map