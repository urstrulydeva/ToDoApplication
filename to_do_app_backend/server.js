require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cors());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/todo_app_tasks' , {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log("MongoDB Connected"))
.catch((err) => console.log(err));

const TaskSchema = new mongoose.Schema({
  title: { type: String, required: true }, 
  completed: { type: Boolean, default: false } 
}, { 
  versionKey: false, 
  timestamps: true  
});

const Task = mongoose.model("Task", TaskSchema);

// API Routes - Implementation of CRUD
app.get("/tasks", async (req, res) => {
  const tasks = await Task.find();
  res.json(tasks);
});

app.post("/tasks", async (req, res) => {
  try {
    const { title } = req.body;
    if (!title) {
      return res.status(400).json({ error: "Title is required" }); // Bad Request
    }
    const newTask = new Task({ title, completed: false });
    await newTask.save();
    res.status(201).json(newTask); // 201 Created
  } catch (err) {
    res.status(500).json({ error: "Internal Server Error" }); // 500 Error for unexpected failures
  }
});


app.patch("/tasks/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const updateFields = req.body; // Allow flexible updates

    const updatedTask = await Task.findByIdAndUpdate(id, updateFields, { new: true });

    if (!updatedTask) {
      return res.status(404).json({ error: "Task not found" });
    }

    res.json(updatedTask);
  } catch (err) {
    res.status(500).json({ error: "Internal Server Error" });
  }
});


app.delete("/tasks/:id", async (req, res) => {
  try {
    const deletedTask = await Task.findByIdAndDelete(req.params.id);
    if (!deletedTask) {
      return res.status(404).json({ error: "Task not found" });
    }
    res.status(204).send(); // 204 No Content
  } catch (err) {
    res.status(500).json({ error: "Internal Server Error" });
  }
});


app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
