import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final String apiUrl = "http://10.0.2.2:5000/tasks";

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _tasks = data.map((json) => Task.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (error) {
      print("Error fetching tasks: $error");
    }
  }

  Future<void> addTask(String title) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'title': title, 'completed': false}),
      );

      if (response.statusCode == 201) { // Check for 201 Created
        _tasks.add(Task.fromJson(json.decode(response.body)));
        notifyListeners();
      } else {
        throw Exception("Failed to add task");
      }
    } catch (error) {
      print("Error adding task: $error");
    }
  }

  Future<void> toggleTask(String id, bool completed) async {
    try {
      final response = await http.patch( // Use PATCH instead of PUT
        Uri.parse("$apiUrl/$id"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'completed': completed}),
      );

      if (response.statusCode == 200) { // API now correctly returns updated task
        int index = _tasks.indexWhere((task) => task.id == id);
        if (index != -1) {
          _tasks[index] = Task.fromJson(json.decode(response.body)); // Update with full response
          notifyListeners();
        }
      } else {
        throw Exception("Failed to update task");
      }
    } catch (error) {
      print("Error updating task: $error");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(Uri.parse("$apiUrl/$id"));
      if (response.statusCode == 204) { // Check for 204 No Content
        _tasks.removeWhere((task) => task.id == id);
        notifyListeners();
      } else {
        throw Exception("Failed to delete task");
      }
    } catch (error) {
      print("Error deleting task: $error");
    }
  }
}
