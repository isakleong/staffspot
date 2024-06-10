import 'package:flutter/material.dart';
import 'package:staffspot/screens/Homepage.dart';

import 'screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Spot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      // home: const Homepage(),
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => Homepage(),
        // '/list': (context) => ListItemScreen(),
        // '/insert': (context) => InsertItemScreen(),
      },
    );
  }
}