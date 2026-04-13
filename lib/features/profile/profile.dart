import 'package:flutter/material.dart';
import 'package:NoteNest/features/auth/screens/login_page.dart';

class Setting extends StatelessWidget {
  final String name='Raj Thummar';
  final String email='rtempiric@gmail.com';
  const Setting({super.key, required String name, required String email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body:  Card(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 60),
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 50),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        'name: $name',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'email: $email',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      const Text('Google Login / Apple Login'),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                          );

                        },
                        child: const Text('Logout'),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }
}
