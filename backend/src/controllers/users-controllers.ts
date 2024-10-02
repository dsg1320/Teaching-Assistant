import { NextFunction, Request, Response } from "express";
import  User  from "../models/User.js";
import bcrypt from "bcryptjs"; 
const { hash, compare } = bcrypt;
import { createToken } from "../utils/token-manager.js";
import { COOKIE_NAME } from "../utils/constants.js";
//import User from "../models/User.js";

export const getAllUsers=async(req:Request, res:Response, next: NextFunction)=> {
    //get all users
    try{
        const users = await User.find();
        return res.status(200).json({message:"OK",users});
    }catch(error){
        return res.status(500).json({message:"Error",cause:error.message});
    }
};

export const userSignup=async(req:Request, res:Response, next: NextFunction)=> {
    //usersignup
    try{
        const{username, email,password}=req.body;
        const existingUser=await User.findOne({ email});
        if(existingUser) return res.status(401).send("User already esists")
        const hashedPassword= await hash(password,10);
        const user = new User({ username, email, password:hashedPassword});
        await user.save();

        //create token and store cookie
        res.clearCookie(COOKIE_NAME,{
            httpOnly:true,
            domain:"localhost",
            signed:true,
            path: "/",
        });
        const token = createToken(user._id.toString(),user.email,"7d");
        const expires=new Date();
        expires.setDate(expires.getDate()+7);
        res.cookie(COOKIE_NAME,token,{path:"/", domain:"localhost",expires,httpOnly:true,signed:true,});

        return res.status(200).json({message:"OK",id:user._id.toString});
    }catch(error){
        return res.status(500).json({message:"Error",cause:error.message});
    }
};

export const userLogin=async(req:Request, res:Response, next: NextFunction)=> {
    //user login
    try{
        const{ email,password}=req.body;
        const user= await User.findOne({email});
        if(!user){
            return res.status(401).send("user not registered");
        }
        const isPasswordCorrect = await compare(password,user.password);
        if(!isPasswordCorrect){
            return res.status(403).send("Incorrect Password");
        }
        res.clearCookie(COOKIE_NAME,{
            httpOnly:true,
            domain:"localhost",
            signed:true,
            path: "/",
        });
        const token = createToken(user._id.toString(),user.email,"7d");
        const expires=new Date();
        expires.setDate(expires.getDate()+7);
        res.cookie(COOKIE_NAME,token,{path:"/", domain:"localhost",expires,httpOnly:true,signed:true,});

        return res.status(200).json({message:"OK",id:user._id.toString});
    }catch(error){
        return res.status(500).json({message:"Error",cause:error.message});
    }
};

export const verifyUser=async(req:Request, res:Response, next: NextFunction)=> {

    try{
        const user= await User.findById(res.locals.jwtData.id);
        if(!user){
            return res.status(401).send("user not registered or token malfunctioned");
        }
        console.log(user.id.toString(),res.locals.jwtData.id)
        if(user.id.toString()!== res.locals.jwtData.id){
            return res.status(401).send("Permissions didnt match");
        }
        return res.status(200).json({message:"OK", username:user.username, email: user.email});
    }catch(error){
        return res.status(500).json({message:"Error",cause:error.message});
    }
};
