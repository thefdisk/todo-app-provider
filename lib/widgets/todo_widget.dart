import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_dicoding1/model/todo_model.dart';
import 'package:submission_dicoding1/pages/edit_page.dart';
import 'package:submission_dicoding1/provider/todo_provider.dart';
import 'package:submission_dicoding1/show_snackbar.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoWidget({@required this.todo, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(todo: todo);
          }));
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Theme.of(context).primaryColor,
                ),
                child: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) {
                    final provider =
                        Provider.of<TodoProvider>(context, listen: false);

                    final isDone = provider.toggleTodoStatus(todo);

                    ShowSnackbar.showSnackbar(context,
                        isDone ? 'Task completed' : 'Task mark incomplete');
                  },
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(
                              fontSize: 20,
                              height: 1.5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.7)),
                        ),
                      )
                  ],
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.delete),
                onPressed: () => deleteTodo(context, todo),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, TodoModel todo) {
    final provider = Provider.of<TodoProvider>(context, listen: false);

    provider.removeTodo(todo);

    ShowSnackbar.showSnackbar(context, 'Deleted the task');
  }
}
