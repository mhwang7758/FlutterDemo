import 'Sport.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AddSport extends StatefulWidget{

  AddSport({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new AddSportState();
  }
}

class AddSportState extends State<AddSport>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("添加运动"),
      ),
      body: Text("添加运动")
    );
  }
}