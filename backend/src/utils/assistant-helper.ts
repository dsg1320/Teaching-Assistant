
import { GoogleGenerativeAI, HarmCategory, HarmBlockThreshold } from "@google/generative-ai"; // ES module import
  const apiKey = "AIzaSyCAgwQKNiamSzkgbqCWdZcNcdSLDsC89Yk";
  //console.log("API Key:", apiKey); // Store API key in .env file
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

        /*const formattedHistory = chatHistory.map(message => ({
            role: message.role === "assistant" ? "model" : message.role, // Map 'assistant' to 'model'
            parts: [{ data: message.content }], // Ensure 'parts' has an array with content
          }));*/
        //console.log("Formatted chat history:", formattedHistory);
        //console.log(chatHistory)
        const chatSession = await model.startChat({
            generationConfig,
            history: [], // Pass chat history to keep context
      });


     console.log(chatHistory[chatHistory.length-1].parts[0].data)
      // Extract the last user's message to send as input
     const lastUserMessage = chatHistory[chatHistory.length - 1].parts[0].data;

        // Send the last user message to the assistant
      const result = await chatSession.sendMessage(lastUserMessage);
  
      return result.response.text();
    } catch (error) {
      console.error('Error generating Socratic response:', error);
      return 'Sorry, I encountered an error. Please try again later.';
    }

  };
