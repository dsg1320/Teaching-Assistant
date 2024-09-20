import { Router } from "express";
import { getAllUsers, userLogin, userSignup } from "../controllers/users-controllers.js";
import { loginValidator, signupvalidator, validate } from "../utils/validators.js";
const useRoutes = Router();
useRoutes.get("/", getAllUsers);
useRoutes.post("/signup", validate(signupvalidator), userSignup);
useRoutes.post("/login", validate(loginValidator), userLogin);
export default useRoutes;
//# sourceMappingURL=user-routes.js.map