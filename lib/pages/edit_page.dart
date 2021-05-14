import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_dicoding1/model/todo_model.dart';
import 'package:submission_dicoding1/provider/todo_provider.dart';
import 'package:submission_dicoding1/show_snackbar.dart';

class EditPage extends StatefulWidget {
  final TodoModel todo;

  const EditPage({Key key, @required this.todo}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // global key untuk validasi
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // memasukkan nilai dari halaman sebelumnya ke dalam controller
  @override
  void initState() {
    super.initState();

    titleController.text = widget.todo.title;
    descController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final provider =
                  Provider.of<TodoProvider>(context, listen: false);

              provider.removeTodo(widget.todo);

              Navigator.of(context).pop();

              ShowSnackbar.showSnackbar(context, 'Deleted the task');
            },
          )
        ],
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
                SizedBox(height: 8),
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
          border: UnderlineInputBorder(),
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
        maxLines: 2,
        controller: descController,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
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
          onPressed: updateTodo,
          child: Text('Edit'),
        ),
      );

  void updateTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodoProvider>(context, listen: false);

      provider.updateTodo(
          widget.todo, titleController.text, descController.text);

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
