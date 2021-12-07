// <uses-permission android:name="android.permission.INTERNET"/>
// flutter build apk --build-name=1.0.1 --build-number=2

import 'package:flutter/material.dart';

// Pages
import 'package:schoenen/pages/login.dart';
import 'package:schoenen/pages/home.dart';
import 'package:schoenen/pages/newshoe.dart';
import 'package:schoenen/pages/shoedetails.dart';

// Google Fonts
import 'package:google_fonts/google_fonts.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:schoenen/providers/themeprov.dart';
import 'package:schoenen/providers/fireprov.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();


  runApp(
    MultiProvider(
      providers: [ 
        ChangeNotifierProvider(
        create: (context) => ThemeProv(),
      ),
        ChangeNotifierProvider(
        create: (context) => FireProv(),
      ),
        StreamProvider <List>(
          create: (context) => FireProv().getCollections,
          initialData:  [],
        ),
      ],
      child: const MyApp()
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
        textTheme: GoogleFonts.robotoTextTheme(),
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
