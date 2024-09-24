import { Router } from "express";
import { handleChat } from '../controllers/chat-controller.js';
const chatRoutes = Router();
// Route to handle chat interactions
chatRoutes.post('/chat', handleChat);
// Route to handle chat interactions
chatRoutes.post('/chat', handleChat);
export default chatRoutes;
//# sourceMappingURL=chat-routes.js.map