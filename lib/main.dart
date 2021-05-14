import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_dicoding1/pages/home_page.dart';
import 'package:submission_dicoding1/provider/todo_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // menginisiasi state management dari provider
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dicoding Submission',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
