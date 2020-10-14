import 'package:flutter/material.dart';
import 'SportRunning.dart';
import 'AddSport.dart';
import 'pages/Register.dart';
import 'pages/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "sportRunning": (context) =>
            SportRunning(sport: ModalRoute.of(context).settings.arguments),
        "addSport": (context) => AddSport(),
        "register": (context) => Register(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home()
    );
  }
}

