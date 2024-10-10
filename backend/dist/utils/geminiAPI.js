import { config } from "dotenv";
config();
//const apiKey = process.env.GEMINI_API_KEY;
export const geminiAPI = {
    evaluateAnswer: async (userAnswer, assistantPrompt) => {
        try {
            const response = await fetch('https://gemini-api.com/evaluate', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer AIzaSyCAgwQKNiamSzkgbqCWdZcNcdSLDsC89Yk ',
                },
                body: JSON.stringify({
                    prompt: `Assistant's question: ${assistantPrompt}\nUser's answer: ${userAnswer}\nEvaluate if the answer is correct or not.`,
                    max_tokens: 10,
                }),
            });
            const data = await response.json();
            console.log('Gemini API Response:', data);
            if (!response.ok) {
                throw new Error(`Gemini API error: ${response.status} - ${response.statusText}`);
            }
            const isCorrect = data.choices[0].text.trim().toLowerCase() === 'yes';
            // Assuming the API returns a response with an 'isCorrect' field
            return isCorrect ? 1 : 0;
        }
        catch (error) {
            console.error('Error evaluating answer:', error);
            throw new Error('Failed to evaluate answer');
        }
    },
};
//# sourceMappingURL=geminiAPI.js.map