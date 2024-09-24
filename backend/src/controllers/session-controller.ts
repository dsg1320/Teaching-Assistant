import User from '../models/User.js';
import Session from '../models/Session.js'; // If session is separate

export const createSession = async (req, res) => {
  try {
    const { userId, sessionName } = req.body;
    
    // Find the user by ID
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Create a new session
    const newSession = new Session({
      userId: user._id,
      sessionName: sessionName || "Untitled Session",
      chatHistory: [],
    });

    // Save the session and push it to user's sessions array
    await newSession.save();

    // Push the new session's ID to the user's sessions array
    user.sessions.push(newSession._id);
    //user.sessions.push({ sessionId: newSession._id, sessionName: newSession.sessionName });
    await user.save();

    return res.status(201).json({ message: "Session created", session: newSession });
  } catch (error) {
    console.error("Error creating session:", error);
    return res.status(500).json({ message: "Failed to create session" });
  }
};
