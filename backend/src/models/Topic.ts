import mongoose from 'mongoose';

const TopicSchema = new mongoose.Schema({
  name: String,
  complexity: String, // 'easy', 'moderate', 'difficult'
});

export default mongoose.model('Topic', TopicSchema);
