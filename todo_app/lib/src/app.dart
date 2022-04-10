import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/auth/auth_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LinkingToAuth(),
    );
  }
}
