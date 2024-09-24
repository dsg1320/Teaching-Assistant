import { generateSocraticResponse } from '../utils/assistant-helper.js';
//import User from '../models/Users.js';
import Session from '../models/Session.js';  // Import Session model

export const handleChat = async (req, res) => {
  try {
    const { sessionId, message } = req.body;

    // Find the session by its ID
    const session = await Session.findById(sessionId);

    if (!session) {
      return res.status(404).json({ error: 'Session not found' });
    }

    // Append the user's message to the session history
    session.chatHistory.push({
      role: "user",
      content: message,
      timestamp: new Date(),
    });

    // Generate the response from Gemini AI
    const assistantMessage = await generateSocraticResponse(session.chatHistory);

    // Append the assistant's response to the session history
    session.chatHistory.push({
      role: "assistant",
      content: assistantMessage,
      timestamp: new Date(),
    });

    // Save the updated session
    await session.save();

    // Send the assistant's response back to the frontend
    res.json({ message: assistantMessage });
  } catch (error) {
    console.error('Error handling chat:', error);
    res.status(500).json({ error: 'Failed to generate response' });
  }
};

