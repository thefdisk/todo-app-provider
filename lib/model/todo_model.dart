import 'package:flutter/material.dart';

class TodoModel {
  String title;
  String description;
  bool isDone;
  DateTime createdTime;

  TodoModel({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.isDone = false,
  });
}
