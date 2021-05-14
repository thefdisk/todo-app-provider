import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_dicoding1/provider/todo_provider.dart';
import 'package:submission_dicoding1/widgets/todo_widget.dart';

class CompletedTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No Completed Task',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (context, index) => Divider(
                  indent: 16,
                  endIndent: 16,
                ),
            itemCount: todos.length);
  }
}
