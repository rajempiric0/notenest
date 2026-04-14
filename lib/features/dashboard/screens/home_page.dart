import 'package:flutter/material.dart';
import 'package:NoteNest/features/profile/profile.dart';

class HomePage extends StatefulWidget {
  final String?  name;
  final String? email;
  const HomePage({super.key,this.name, this.email});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _taskController.addListener(() {
      final String Text = _taskController.text.trim();
      _taskController.value = _taskController.value.copyWith(
        text: Text,
        composing: TextRange.empty,
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting(name: 'raj', email: 'raj@gmail.com',)),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Add Task'),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Add Task'),
                      content: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (value) => FontWeight.bold,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context, _taskController),
                          child: const Text('Submit'),
                          autofocus: true,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black26,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
