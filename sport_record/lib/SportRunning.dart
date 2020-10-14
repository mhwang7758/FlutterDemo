import 'Sport.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class SportRunning extends StatefulWidget{

  SportRunning({
    Key key,
    @required this.sport
  }) : super(key: key);


  final Sport sport;

  @override
  State<StatefulWidget> createState() {
    return new SportRunningState();
  }

}

class SportRunningState extends State<SportRunning>{

  var text = "开始";

  bool hasStart = false;

  Timer _timer;
  int _countDown;

  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState(){
    super.initState();
    _countDown = 60 * widget.sport.getTime();
  }

  _startCountDown(){

    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(oneSec, (timer) {
      if (mounted){
        setState(() {

          if (_countDown <= 0){
            hasStart = false;
            _timer.cancel();
            text = "已成功";
            Future.delayed(Duration(seconds: 3), (){
              Navigator.of(context).pop(widget.sport.getId());
            });

          }else{
            _countDown--;
            text = _countDown.toString();
          }
        });
      }
    });
  }

  _getTitle(){
    return new Container(
      margin: const EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: new Text(
          widget.sport.name,
          style: new TextStyle(
            fontSize: 40,
            color: Colors.black
          )),
    );
  }

  _getTime() {
    return new Container(
        alignment: Alignment.center,
        child: new Text(
          "运动" + widget.sport.time.toString() + "分钟",
          style: new TextStyle(
              fontSize: 20,
              color: Colors.black
          ),
        )
    );
  }

  _getStartButton(){
    return new Center(
      child: new GestureDetector(
        child: new Container(
            width: 200,
            height: 200,
            decoration: new BoxDecoration(
                border: new Border.all(
                    color: hasStart ? Colors.red : Colors.green,
                    width: 5
                ),
                borderRadius: new BorderRadius.circular(20)
            ),
            alignment: Alignment.center,
            child: new Text(
              text,
              style: new TextStyle(
                  color: Colors.red,
                  fontSize: hasStart ? 80 : 40
              ),
            )
        ),

        onTap: (){
          if (!hasStart) {
            hasStart = true;
            _startCountDown();
          }
        },
      )

    );
  }

  _back(){
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

//    var args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: _back),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: _getTitle(),
            ),

            new Expanded(
              flex: 1,
              child: _getTime(),
            ),

            new Expanded(
                flex: 4,
                child: _getStartButton())
          ],
        ),
      ),
    );
  }
}