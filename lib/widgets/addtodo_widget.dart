import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_dicoding1/model/todo_model.dart';
import 'package:submission_dicoding1/provider/todo_provider.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  // global key untuk validasi
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTitle(),
                SizedBox(height: 11),
                buildDescription(),
                SizedBox(height: 16),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        style: TextStyle(color: Colors.black),
        maxLines: 1,
        controller: titleController,
        validator: (title) {
          if (title.isEmpty) {
            return 'Title tidak boleh kosong';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      );

  Widget buildDescription() => TextFormField(
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.white,
        maxLines: 2,
        controller: descController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: saveTodo,
          child: Text('Save'),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = TodoModel(
        createdTime: DateTime.now(),
        title: titleController.text,
        description: descController.text,
      );

      final provider = Provider.of<TodoProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }

  // menutup controller agar tidak terjadi memory leak
  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
}
