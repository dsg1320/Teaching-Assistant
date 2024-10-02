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
   GEMINI_API_KEY=
   MONGODB_URL=
   JWT_SECRET=
   COOKIE_SECRET=
   PORT=5001
5. **Run the Application**:  
   Run backend:  
   ```bash
    npm run dev
   ```
   Run Frontend:
   ```bash
   flutter run
   ```
## Results
<div style="text-align: center;">

**Login**  
<img src="app%20images/app%20images/login.png" alt="Login page" width="300"/>

**Session Start**  
<img src="app%20images/app%20images/chat%20start.png" alt="Start a new session" width="300"/>

**Session responses**  
<img src="app%20images/app%20images/chat%20responses.png" alt="Socratic teaching assistant responses" width="300"/>

**Code generation**  
<img src="app%20images/app%20images/chat%20code%20gen.png" alt="Teaching assistant code generation" width="300"/>

**Session List**  
<img src="app%20images/app%20images/session%20list.png" alt="The list of sessions created by the user" width="300"/>

</div>



## License
This project is licensed under the MIT License.


