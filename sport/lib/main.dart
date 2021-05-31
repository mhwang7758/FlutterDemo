import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new SportList(),
    );
  }
}

class SportList extends StatefulWidget{
  SportList({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return new SportListState();
  }
}

class SportListState extends State<SportList>{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('sport'),
      ),

      body: new ListView(children: _getListData(),),
    );
  }

  _getListData(){
    List<Widget> widgets = [];

    for (int i = 0; i< 100; i++){
      widgets.add(getRow("assets/unfinish.png", "i"));
    }

    return widgets;
  }

  Row getRow(String icon, String title){
    return new Row(
      children: <Widget>[
        new Image.asset(
            icon,
            width: 64,
            height: 64,
        ),
        new Text(
          title,
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey
          ),
        )
      ],
    );
  }
}
