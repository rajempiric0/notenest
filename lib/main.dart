import 'package:NoteNest/features/onbording/splash_screen.dart';
import 'package:NoteNest/features/tasks/pages/task_bindings.dart';
import 'package:NoteNest/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NoteNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF794098), // Primary Accent.
          surface: Colors.grey[900], // Dark Surface
        ),
        useMaterial3: true,
      ),
      home: Splashscreen(),
      initialBinding: TaskBindings(),
    );
  }
}
