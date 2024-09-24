import { createSession } from '../controllers/session-controller.js';
import { Router } from 'express';
const sessionRoutes = Router();

// POST /create-session route
sessionRoutes.post('/create-session', createSession);

export default sessionRoutes;