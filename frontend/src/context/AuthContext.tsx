/* eslint-disable @typescript-eslint/no-unused-vars */
import { createContext, ReactNode, useContext, useEffect, useState } from "react";
import { FaBullseye } from "react-icons/fa6";
import { checkAuthStatus, loginUser } from "../helpers/api-communicator";

type User = {
    username: string
    email: string
};
type UserAuth = {
    isLoggedIn: boolean;
    user: User | null;
    login: (email: string,password: string)=> Promise<void>;
     signup: (username: string,email:string,password: string)=> Promise<void>;
    logout: ()=> Promise<void>;
};

const AuthContext = createContext<UserAuth | null>(null);
export const AuthProvider = ({children}: { children: ReactNode})=>{
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const [user,setUser]= useState<User | null>(null);
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const [isLoggedIn,setIsLoggedIn]= useState(false);

    useEffect(()=>{
        async function checkStatus() {
            const data= await checkAuthStatus();
            if (data){
                setUser({email:data.email, username: data.name});
                setIsLoggedIn(true);
            }
        }
        checkStatus();
    }, []);
    const login = async (email: string, password:string)=>{
        const data= await loginUser(email,password);
        if (data){
            setUser({email:data.email, username: data.name});
            setIsLoggedIn(true);
        }
    };
    const signup=async(username: string, email:string, password: string)=>{};
    const logout = async ()=>{};

    const value = {
        user,
        isLoggedIn,
        login,
        logout,
        signup,
    };
    return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = ()=> useContext(AuthContext);