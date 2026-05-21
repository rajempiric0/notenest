import 'package:NoteNest/features/onbording/pages/splash_screen.dart';
import 'package:NoteNest/features/tasks/bindings/task_bindings.dart';
import 'package:NoteNest/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:NoteNest/features/setting/Language_translation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();

  final langCode = prefs.getString('languageCode') ?? 'en';
  final countryCode = prefs.getString('countryCode') ?? 'US';
  runApp(MyApp(savedLocale: Locale(langCode, countryCode)));
}

class MyApp extends StatelessWidget {
  final  Locale savedLocale;
  const MyApp({super.key,required this.savedLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NoteNest',
      debugShowCheckedModeBanner: false,
      translations: LanguageTranslation(),

      locale: savedLocale,
      fallbackLocale: const Locale('en', 'US'),

      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
        Locale('gu', 'IN'),
        Locale('mr', 'IN'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF794098),
          surface: Colors.grey[900],
        ),
        useMaterial3: true,
      ),
      home: Splashscreen(),
      initialBinding: TaskBindings(),
    );
  }
}
