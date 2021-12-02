// <uses-permission android:name="android.permission.INTERNET"/>
// flutter build apk --build-name=1.0.3 --build-number=3

import 'package:flutter/material.dart';

// Pages
import 'package:schoenen/pages/login.dart';
import 'package:schoenen/pages/home.dart';
import 'package:schoenen/pages/newshoe.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();


  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProv(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => const Home(),
        '/newshoe': (context) => const NewShoe(),
      },
    );
  }
}
