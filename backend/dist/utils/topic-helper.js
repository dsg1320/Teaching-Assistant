import Topic from '../models/Topic.js';
export const identifyTopic = (message) => {
    if (message.includes('bubble sort'))
        return 'Bubble Sort';
    if (message.includes('merge sort'))
        return 'Merge Sort';
    if (message.includes('heap sort'))
        return 'Heap Sort';
    return null;
};
export const calculateComplexity = async (message) => {
    const topicName = identifyTopic(message);
    if (!topicName)
        return null;
    // Fetch the topic from the database
    const topic = await Topic.findOne({ name: topicName });
    return topic ? topic.complexity : null;
};
//# sourceMappingURL=topic-helper.js.map