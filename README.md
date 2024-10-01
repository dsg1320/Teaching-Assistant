# A.T.L.A.S - Teaching Assistant

This project is an AI-powered teaching assistant built to help students learn Sorting Algorithms like Bubble Sort, Merge Sort, Quick Sort, and others through a Socratic method of questioning. It utilizes Gemini AI for intelligent responses and provides real-time assistance in understanding key concepts in Data Structures and Algorithms (DSA).

## Features

1. Socratic method of learning
2. Supports various sorting algorithms and DSA
3. Interactive Q&A for student engagement
4. Has real-time response memory

## Tech Stack

- **Backend**: Node.js, Express.js, MongoDB (Mongoose)
- **Frontend**: Flutter
- **AI**: Gemini AI Model (1.5 flash)

## Installation & Setup

### Prerequisites

- Node.js (version 14.x or above)
- Flutter SDK
- MongoDB setup (Mongoose)
-  Git

### Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dsg1320/Teaching-Assistant.git
   cd Teaching-Assistant
2. **Install backend dependencies (Node.js dependencies)**:
   ```bash
   cd backend
   npm install
3. **Install frontend dependencies (Flutter dependencies)**:
   ```bash
   cd frontend
   flutter pub get
4. **Set Up Environment Variables**:
   Create a **.env** file in the backend folder with the following details:
   ```bash
   MONGO_URI=
   PORT=5001
   GEMINI_API_KEY=
5. **Run the Application**:  
   Run backend:  
   ```bash
    npm run dev
   ```
   Run Frontend:
   ```bash
   flutter run
   ```
## License
This project is licensed under the MIT License.


