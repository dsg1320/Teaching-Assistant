import { createSession, deleteSessionById, getChatHistoryBySessionId, getSessionsByUser } from '../controllers/session-controller.js';
import { Router } from 'express';
const sessionRoutes = Router();
// POST /create-session route
sessionRoutes.post('/create-session', createSession);
sessionRoutes.get('/get/:userId', getSessionsByUser);
sessionRoutes.get('/chat/:sessionId', getChatHistoryBySessionId);
sessionRoutes.delete('/:sessionId', deleteSessionById);
export default sessionRoutes;
//# sourceMappingURL=session-routes.js.map