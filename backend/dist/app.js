import express from 'express';
import { config } from "dotenv";
import morgan from "morgan";
import appRouter from './routes/index.js';
import cookieParser from 'cookie-parser';
import cors from "cors";
config();
const app = express();
// Middleware
app.use(express.json());
app.use(cookieParser(process.env.COOKIE_SECRET));
app.use(morgan("dev"));
app.use(cors()); // Add the CORS middleware here
app.use("/api/v1", appRouter); // Mount all routes under /api/v1
export default app;
//# sourceMappingURL=app.js.map