import { Router } from "express";
import useRoutes from "./user-routes.js";
import chatRoutes from "./chat-routes.js";
import sessionRoutes from "./session-routes.js";
const appRouter = Router();
appRouter.use("/user", useRoutes); //domain/api/v1/user
appRouter.use("/chats", chatRoutes); //domain/api/v1/chats
appRouter.use("/sessions", sessionRoutes);
export default appRouter;
//# sourceMappingURL=index.js.map