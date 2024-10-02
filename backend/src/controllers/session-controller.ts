import User from '../models/User.js';
import Session from '../models/Session.js'; // If session is separate
import { Request, Response } from 'express';

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

export const getSessionsByUser = async (req: Request, res: Response) => {
  const { userId } = req.params;

  try {
      const sessions = await Session.find({ userId }).select('sessionName _id');
      
      if (!sessions) {
          return res.status(404).json({ message: 'No sessions found for this user.' });
      }

      res.status(200).json(sessions);
  } catch (error) {
      res.status(500).json({ message: 'Server error', error });
  }
};
// Function to get the chat history by session ID
export const getChatHistoryBySessionId = async (req: Request, res: Response) => {
  const { sessionId } = req.params; // Extract sessionId from params

  try {
      // Find the session by sessionId and return the chatHistory
      const session = await Session.findById(sessionId).select('chatHistory');

      // If the session doesn't exist, return a 404 response
      if (!session) {
          return res.status(404).json({ message: 'Session not found.' });
      }

      // Return the chat history of the found session
      res.status(200).json(session.chatHistory);
  } catch (error) {
      // Handle any errors during the database query
      res.status(500).json({ message: 'Server error', error });
  }
};

export const deleteSessionById = async (req: Request, res: Response) => {
  try {
    const { sessionId } = req.params;

    // Find the session before attempting to delete
    const sessionToDelete = await Session.findById(sessionId);
    if (!sessionToDelete) {
      return res.status(404).json({ message: 'Session not found' });
    }

    // Delete the session
    const deletedSession = await Session.findByIdAndDelete(sessionId);
    if (!deletedSession) {
      return res.status(404).json({ message: 'Session not found during deletion' });
    }

    // Update the user document to remove the reference to the deleted session
    const userId = sessionToDelete.userId; // Assuming `userId` is a field in the Session schema
    await User.findByIdAndUpdate(userId, {
      $pull: { sessions: sessionId },// Remove the sessionId from the user's sessions array
      $inc: { __v: -1 },
    });

    res.status(200).json({ message: 'Session deleted successfully' });
  } catch (error) {
    console.error('Error deleting session:', error);
    res.status(500).json({ message: 'An error occurred while deleting the session', error });
  }
};