import 'package:flutter/material.dart';
import 'package:tasks_app/login_form.dart';
import 'package:tasks_app/register_form.dart';
import 'package:tasks_app/register_task_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de usuarios:';

    return MaterialApp(
      title: appTitle,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginForm(),
        '/tasks': (context) => RegisterTaskForm(),
        '/register': (context) => RegisterForm(),
      },
    );
  }
}

