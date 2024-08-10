// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:project/home_page.dart';
import 'package:project/splasch.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => HomePage(),
        // "signup": (context) => Signup(),
      },
    );
  }
}
