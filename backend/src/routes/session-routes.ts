import { createSession, deleteSessionById, getChatHistoryBySessionId, getSessionsByUser, updateSessionPerformance,getPerformanceScoresByUser, getAveragePerformanceScoreByUser } from '../controllers/session-controller.js';
import { Router } from 'express';
const sessionRoutes = Router();

// POST /create-session route
sessionRoutes.post('/create-session', createSession);
sessionRoutes.get('/get/:userId', getSessionsByUser);
sessionRoutes.get('/chat/:sessionId', getChatHistoryBySessionId);
sessionRoutes.delete('/:sessionId', deleteSessionById);
sessionRoutes.get('/performance/:userId', getPerformanceScoresByUser);
sessionRoutes.get('/average-performance/:userId', getAveragePerformanceScoreByUser);

sessionRoutes.put('/update-performance/:sessionId', async (req, res) => {
    try {
      await updateSessionPerformance(req.params.sessionId);
      res.status(200).json({ message: 'Performance updated successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Error updating performance', error });
    }
  });

export default sessionRoutes;