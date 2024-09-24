import { Router } from "express";
import { getAllUsers, userLogin, userSignup, verifyUser } from "../controllers/users-controllers.js";
import { loginValidator, signupvalidator, validate } from "../utils/validators.js";
import { verifyToken } from "../utils/token-manager.js";
const useRoutes = Router();
useRoutes.get("/", getAllUsers);
useRoutes.post("/signup", validate(signupvalidator), userSignup);
useRoutes.post("/login", validate(loginValidator), userLogin);
useRoutes.get("/auth-status", verifyToken, verifyUser);
export default useRoutes;
//# sourceMappingURL=user-routes.js.map