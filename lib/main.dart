//imported libraries
import 'package:flutter/material.dart';

//dart file references
import './screens/home.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //keep time, battery percentage display at top of screen
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //displays the Home screen.
      home: Home(),
    );
  }
}