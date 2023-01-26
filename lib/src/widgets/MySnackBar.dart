import 'package:flutter/material.dart';

class MySnackBar {

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 50,
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: const Color(0xFFFFFFFF),
            fontSize: MediaQuery.of(context).size.height * 2 / 100,
          ),
        ),
        duration: const Duration(seconds: 2)
      ),
    );
  }

}