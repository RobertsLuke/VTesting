import 'package:flutter/material.dart';
import '../Objects/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    print("Adding task to provider: ${task.title} with tags: ${task.listOfTags}");
    _tasks.add(task);
     print("Task added to provider: ${task.title} with tags: ${task.listOfTags}");
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.title == updatedTask.title);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Task? getTask(String title) {
  try {
    return _tasks.firstWhere((task) => task.title == title);
  } catch (e) {
    return null;
  }
}

}
