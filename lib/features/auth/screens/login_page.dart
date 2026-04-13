import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  final TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class Todo {
  String name;
  String emailId;
  String password;

  Todo({required this.name, required this.emailId, required this.password});

}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.topLeft,
                end:Alignment.bottomRight,
                colors:[Colors.grey,Colors.teal]),
          ),
        )

    );
  }
}





