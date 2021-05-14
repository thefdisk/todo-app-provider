import 'package:flutter/material.dart';

class ShowSnackbar {
  static void showSnackbar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
}
