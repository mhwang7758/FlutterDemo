import 'package:flutter/material.dart';
import 'package:stock_analysis/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      routes: {
        "Home":(context) => Home(),
      },
      home: Home(),
    );
  }
}


