import 'package:flutter/material.dart';
import 'package:quiz_app_prac/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
