export const calculateNumberOfQuestions = (chatHistory) => {
    return chatHistory.filter(msg => msg.role === 'assistant').length;
};
export const calculateComplexity = (chatHistory) => {
    const complexityScores = { easy: 1, moderate: 2, difficult: 3 };
    const complexities = chatHistory.map(msg => complexityScores[msg.complexity] || 0);
    return complexities.length ? complexities.reduce((a, b) => a + b) / complexities.length : 0;
};
export const calculatePerformanceScore = (numQuestions, complexity) => {
    const weights = { numQuestions: 0.6, complexity: 0.4 };
    return (((numQuestions) * weights.numQuestions) + (complexity * weights.complexity) * 100);
};
//# sourceMappingURL=performance-calculator.js.map