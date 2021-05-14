import 'package:flutter/material.dart';
import 'package:submission_dicoding1/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // dummy data
  List<TodoModel> _todos = [
    TodoModel(
      createdTime: DateTime.now(),
      title: 'Coding',
      description: 'Project Flutter',
    ),
    TodoModel(
      createdTime: DateTime.now(),
      title: 'Play Game',
      description: 'Main game Pes',
    ),
    TodoModel(
      createdTime: DateTime.now(),
      title: 'Tidur',
      description: 'Tidur Sampe pagi',
    )
  ];

  // getter untuk mendapatkan semua task
  List<TodoModel> get todos =>
      _todos.where((todo) => todo.isDone == false).toList();

  // getter untuk mendapatkan task yang completed
  List<TodoModel> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(TodoModel todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(TodoModel todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  // method untuk menangani checkbox
  bool toggleTodoStatus(TodoModel todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(TodoModel todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
