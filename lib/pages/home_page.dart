import 'package:flutter/material.dart';
import 'package:submission_dicoding1/widgets/addtodo_widget.dart';
import 'package:submission_dicoding1/widgets/completed_todo_widget.dart';
import 'package:submission_dicoding1/widgets/todolist_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variable disetel ke 0, berarti tabs pertama yang akan dipilih
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // BottomNavigationBar dengan 2 item
    final tabs = [
      TodoListWidget(),
      CompletedTodo(),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTodo();
          }));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
