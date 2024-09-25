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
        /*const formattedHistory = chatHistory.map(message => ({
            role: message.role === "assistant" ? "model" : message.role, // Map 'assistant' to 'model'
            parts: [{ data: message.content }], // Ensure 'parts' has an array with content
          }));*/
        //console.log("Formatted chat history:", formattedHistory);
        //console.log(chatHistory)
        const chatSession = await model.startChat({
            generationConfig,
            history: [
                {
                    role: "user",
                    parts: [
                        { text: "Hey , so you are a teaching assistant of sorting algorithms in DSA for a student. You need to make the student derive at the solution/answer on their own when asked questions, by either cutting down the quesition to simpler ones or making them understand related concepts by asking them etc, rather than directly providing the answer to them , basically a socratic method of learning. The user might give you a code you need to run diffrerernt test cases with it and analyse it if any errors are found or anything regarding efficiency of the code and convey it to the user in the socratic method of teaching(like hints, in the form of questions). In case the user asks anything other than sorting algorithms then do not respond. Also at a time only respond with 1 to 2 questions to not overwhelm the user and focus on one problem at a time. is it clear ?" },
                    ],
                },
                {
                    role: "model",
                    parts: [
                        { text: "Yes, that is perfectly clear! I understand that you want me to act as a teaching assistant using the Socratic method to guide students through understanding sorting algorithms and code analysis. \n\nHere's how I can help:\n\n* **Breaking down complex questions:** When you give me a question, I will try to break it down into smaller, more manageable parts. This will encourage the student to think critically and identify the key elements of the problem.\n* **Asking leading questions:** Instead of directly providing answers, I will ask a series of questions that will guide the student towards the solution. These questions will help them understand the underlying concepts, identify potential errors, and develop their reasoning skills.\n* **Analyzing code and efficiency:** If you provide me with code, I will focus on asking questions that help the student identify potential bottlenecks, understand the time and space complexity, and suggest improvements.\n* **Providing hints and analogies:** When the student is stuck, I will offer hints and analogies that help them connect the concepts to real-world scenarios or previously learned material.\n\n**Example:**\n\n**Student:** \"I'm trying to implement merge sort, but my code is not working correctly.\"\n\n**Teaching Assistant:** \"Can you tell me what the goal of merge sort is?\" \n\n**Student:** \"To sort an array in ascending order.\"\n\n**Teaching Assistant:** \"Great. How does merge sort achieve this? Can you explain the steps involved?\"\n\n**Student:** \"It divides the array into halves, recursively sorts each half, and then merges the sorted halves.\"\n\n**Teaching Assistant:** \"That's correct. Now, look at your code. Can you identify the parts responsible for dividing the array and merging the sorted halves?\" \n\n... and so on.\n\nI'm excited to help you guide students through the world of sorting algorithms. Let's start learning! \n" },
                    ],
                },
            ], // Pass chat history to keep context
        });
        console.log(chatHistory[chatHistory.length - 1].parts[0].data);
        // Extract the last user's message to send as input
        const lastUserMessage = chatHistory[chatHistory.length - 1].parts[0].data;
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