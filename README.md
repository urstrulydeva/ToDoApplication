# To-Do App

This is a **To-Do List Application** built with **Node.js (Express.js) and MongoDB** for the backend and **Flutter** for the frontend.

## Features
- Add, update, and delete tasks
- Mark tasks as completed
- Uses RESTful API for backend operations
- Uses Provider for state management in Flutter
- Simple and intuitive UI

## Tech Stack
### Backend:
- **Node.js** with **Express.js**
- **MongoDB** (via Mongoose ODM)
- **CORS** for cross-origin access
- **dotenv** for environment variables

### Frontend:
- **Flutter** (Dart)
- **Provider** for state management
- **HTTP** for API requests

---

## Getting Started
### 1️⃣ Backend Setup
#### Prerequisites
- **Node.js** installed
- **MongoDB** installed and running locally or use **MongoDB Atlas**

#### Install Dependencies
```bash
cd backend  # Move to your backend directory if applicable
npm install
```

#### Set Up Environment Variables
Create a `.env` file in the root directory and add:
```
MONGO_URI=mongodb://localhost:27017/todo_app_tasks
PORT=5000
```

#### Run the Backend Server
```bash
npm start
```
_Server should start at **http://localhost:5000**_

---

### 2️⃣ Frontend Setup
#### Prerequisites
- **Flutter SDK** installed

#### Install Dependencies
```bash
cd frontend  # Move to your frontend directory if applicable
flutter pub get
```

#### Run the App
```bash
flutter run
```

---

## API Endpoints
### **GET /tasks**  
📌 Fetch all tasks.
```json
[
  {
    "_id": "123",
    "title": "Buy groceries",
    "completed": false
  }
]
```

### **POST /tasks**  
📌 Create a new task.
#### Request Body:
```json
{
  "title": "New Task"
}
```
#### Response:
```json
{
  "_id": "123",
  "title": "New Task",
  "completed": false
}
```

### **PATCH /tasks/:id**  
📌 Update task completion status.
#### Request Body:
```json
{
  "completed": true
}
```

### **DELETE /tasks/:id**  
📌 Delete a task.
_Response: **204 No Content**_


## Contributors
- **Your Name** ([@urstrulydeva]((https://github.com/urstrulydeva)))

## License
MIT License

