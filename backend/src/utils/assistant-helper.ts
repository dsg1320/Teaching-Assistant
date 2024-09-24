// src/utils/assistant-helper.ts
import { GoogleGenerativeAI, HarmCategory, HarmBlockThreshold } from "@google/generative-ai"; // ES module import

  
  const apiKey = process.env.GEMINI_API_KEY; // Store API key in .env file
  const genAI = new GoogleGenerativeAI(apiKey);
  
  const model = genAI.getGenerativeModel({
    model: "gemini-1.5-flash", // Use the model provided by Gemini
  });
  
  const generationConfig = {
    temperature: 1,
    topP: 0.95,
    topK: 64,
    maxOutputTokens: 8192,
    responseMimeType: "text/plain",
  };
  
  export const generateSocraticResponse = async (chatHistory) => {
    try {
      const chatSession = model.startChat({
        generationConfig,
        history: chatHistory, // Pass chat history to keep context
      });
  
      // Send a message to the assistant
      const result = await chatSession.sendMessage(
        "INSERT_USER_QUESTION_HERE" // Replace with dynamic input
      );
      return result.response.text();
    } catch (error) {
      console.error('Error generating Socratic response:', error);
      return 'Sorry, I encountered an error. Please try again later.';
    }
  };
  