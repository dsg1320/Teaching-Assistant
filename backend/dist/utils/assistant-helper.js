import { GoogleGenerativeAI } from "@google/generative-ai"; // ES module import
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
        const initialContext = [
            {
                role: "user",
                parts: [
                    {
                        text: "Hey, you are a teaching assistant specializing in all Data Structures and Algorithms (DSA) concepts for a student. Your role is to guide the student to derive the correct solution or answer independently, using the Socratic method. This means asking questions that simplify the problem, helping the student understand related concepts, and encouraging critical thinking without giving direct answers right away.The student may start by either submitting code or asking a question. When this happens, respond in a Socratic manner, leading the student step-by-step towards the correct conclusion or answer. Analyze the student's response to see if it matches the expected answer. If the answer is correct, congratulate the student and move on to the next topic or question. If the answer is incorrect and the student struggles for more than six questions, provide the correct answer or code in a clear manner.Make sure to:Cover all topics related to DSA but don't respond to question other than DSA.Respond with only 1 to 2 questions at a time to avoid overwhelming the student.If the student requests the code explicitly, provide the correct code immediately.Your main goal is to help the student learn by actively engaging them, analyzing their responses, and giving appropriate guidance in a patient and supportive way. Is this clear?",
                    },
                ],
            },
            {
                role: "model",
                parts: [
                    {
                        text: "Yes, that is perfectly clear. I understand my role as a teaching assistant specializing in DSA, using the Socratic method to guide students towards independent solutions. I'm ready to start! Please feel free to ask any question or share your code related to DSA. I'll be happy to assist you in your learning journey",
                    },
                ],
            },
        ];
        // Format chat history properly with role and text fields
        const formattedHistory = [
            ...initialContext,
            ...chatHistory
        ];
        console.log("Formatted History Being Sent:", JSON.stringify(formattedHistory, null, 2));
        /*const formattedHistory = chatHistory.map(message => ({
            role: message.role === "assistant" ? "model" : message.role, // Map 'assistant' to 'model'
            parts: [{ data: message.content }], // Ensure 'parts' has an array with content
          }));*/
        //console.log("Formatted chat history:", formattedHistory);
        //console.log(chatHistory)
        const chatSession = await model.startChat({
            generationConfig,
            history: formattedHistory
        });
        //console.log(chatHistory[chatHistory.length-1].parts[0].data)
        // Extract the last user's message to send as input
        const lastUserMessage = chatHistory[chatHistory.length - 1].parts[0].text;
        // Send the last user message to the assistant
        const result = await chatSession.sendMessage(lastUserMessage);
        return result.response.text();
    }
    catch (error) {
        console.error('Error generating Socratic response:', error);
        return 'Sorry, I encountered an error. Please try again later.';
    }
};
//# sourceMappingURL=assistant-helper.js.map