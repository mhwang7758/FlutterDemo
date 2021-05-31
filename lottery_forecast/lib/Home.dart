import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery_forecast/module/Lottery.dart';
import 'package:lottery_forecast/module/ball.dart';
import 'dart:convert';

import 'package:lottery_forecast/module/ju_he_lottery_entity.dart';
import 'package:lottery_forecast/module/my_net_lottery_data_entity.dart';
import 'package:lottery_forecast/utils/lottery_forecast.dart';
import 'package:lottery_forecast/widgets/lottery_ball.dart';
import 'package:lottery_forecast/module/ball_num_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  // static const String LOTTERY_SERVER = "http://localhost:9999/lottery";
  static const String LOTTERY_SERVER = "https://www.52code.tech/lottery";
  List<Lottery> _lotteryList = new List();
  int _juHePageIndex = 1;
  int _pageCount = 50;    // 每页数量
  int _juHeTotalPageCount = -1;  // 总数量
  String checkBallState = "";

  LotteryForecast forecast;
  List<List<Ball>> ballLists;
  List<Ball> balls;
  List<BallNumButton> ballNumButtons;
  int lotteryCounts = 0;
  int createCounts;
  bool showDataBtn = false;

  // bool checkingBall = false;
  static const int PER_MAX_COUNT = 5; // 单次彩票生成的最多数量

  @override
  void initState() {
    super.initState();

    _getMyData();

    ballLists = new List();
    ballNumButtons = new List();
    ballNumButtons.add(new BallNumButton("1", true));
    ballNumButtons.add(new BallNumButton("2", true));
    ballNumButtons.add(new BallNumButton("3", true));
    ballNumButtons.add(new BallNumButton("4", true));
    ballNumButtons.add(new BallNumButton("5", true));
    // 初始化列表
    for (int i = 0; i < PER_MAX_COUNT; i++) {
      List<Ball> ball = new List();
      ballLists.add(ball);
    }
    balls = ballLists[lotteryCounts];

    forecast = new LotteryForecast();
    forecast.setOnBallCheck((progress, checkBall) {
      setState(() {
        checkBallState = progress + checkBall.toString();
      });
    }, (ball, percent) {
      setState(() {
        balls.add(ball);
        if (balls.length % 7 == 0) {
          // 排序
          Ball lastBall = balls.removeLast();
          balls.sort((a, b) => a.num.compareTo(b.num));
          balls.add(lastBall);
          lotteryCounts = lotteryCounts + 1;
          if (lotteryCounts < createCounts) {
            balls = ballLists[lotteryCounts];
          } else {
            checkBallState = "已全部生成";
          }
        }
      });
      print("选中的球为=>" + ball.num.toString() + "概率=>" + percent.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _getAppTitle("彩票"),
        // title: Text("彩票"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            showDataBtn
                ? new MaterialButton(child: Text("获取彩票数据"), onPressed: _getData)
                : Container(),
            // showDataBtn
            //     ? new MaterialButton(child: Text("上传彩票数据"), onPressed: _addData)
            //     : Container(),
            Text(
              "请点击下方相应的按钮生成彩票数量:",
              style: new TextStyle(
                  color: Colors.blue, fontSize: ScreenUtil().setSp(20)),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _getButton(ballNumButtons[0], _onButton1Press),
                  ),
                  Expanded(
                    flex: 1,
                    child: _getButton(ballNumButtons[1], _onButton2Press),
                  ),
                  Expanded(
                    flex: 1,
                    child: _getButton(ballNumButtons[2], _onButton3Press),
                  ),
                  Expanded(
                    flex: 1,
                    child: _getButton(ballNumButtons[3], _onButton4Press),
                  ),
                  Expanded(
                    flex: 1,
                    child: _getButton(ballNumButtons[4], _onButton5Press),
                  ),
                ],
              ),
            ),
            Text(
              checkBallState,
              style: new TextStyle(
                  fontSize: ScreenUtil().setWidth(10), color: Colors.red),
            ),
            Expanded(
              child: _getBallList(),
            ),
          ],
        ),
      ),
    );
  }

  _getAppTitle(String txt) {
    return new GestureDetector(
      child: Text(txt,
          style: new TextStyle(
              fontSize: ScreenUtil().setWidth(10), color: Colors.white)),
      onLongPress: _showDataButton,
    );
  }

  _showDataButton() {
    setState(() {
      showDataBtn = true;
    });
  }

  _isCreatingLottery() {
    for (BallNumButton b in ballNumButtons) {
      if (!b.enable) {
        return true;
      }
    }

    return false;
  }

  _onButton1Press() async{
    if (_isCreatingLottery()) {
      _showLotteryBusyToast();
      return;
    }

    setState(() {
      ballNumButtons[0].enable = false;
    });
    await _onCheckBalls(1);
    setState(() {
      ballNumButtons[0].enable = true;
    });
  }

  _onButton2Press() async{
    if (_isCreatingLottery()) {
      _showLotteryBusyToast();
      return;
    }

    setState(() {
      ballNumButtons[1].enable = false;
    });
    await _onCheckBalls(2);
    setState(() {
      ballNumButtons[1].enable = true;
    });
  }

  _onButton3Press() async{
    if (_isCreatingLottery()) {
      _showLotteryBusyToast();
      return;
    }

    setState(() {
      ballNumButtons[2].enable = false;
    });
    await _onCheckBalls(3);
    setState(() {
      ballNumButtons[2].enable = true;
    });
  }

  _onButton4Press() async{
    if (_isCreatingLottery()) {
      _showLotteryBusyToast();
      return;
    }

    setState(() {
      ballNumButtons[3].enable = false;
    });
    await _onCheckBalls(4);
    setState(() {
      ballNumButtons[3].enable = true;
    });
  }

  _showLotteryBusyToast() {
    Fluttertoast.showToast(
        msg: "请等待当前彩票生成结束",
        textColor: Colors.red,
        gravity: ToastGravity.CENTER);
  }

  _onButton5Press() async{
    if (_isCreatingLottery()) {
      _showLotteryBusyToast();
      return;
    }

    setState(() {
      ballNumButtons[4].enable = false;
    });
    await _onCheckBalls(5);
    setState(() {
      ballNumButtons[4].enable = false;
    });
  }

  _onCheckBalls(int num) async{
    if (ballLists[0].isNotEmpty) {
      _clearLastLotteries();
    }
    createCounts = num;
    await _checkBall(createCounts);
  }

  _clearLastLotteries() {
    setState(() {
      for (List<Ball> b in ballLists) {
        b.clear();
      }
      balls = ballLists[0];
      lotteryCounts = 0;
    });
  }

  _checkBall(int num) async {
    int ballNum = 7 * num;
    for (int i = 0; i < ballNum; i++) {
      if (i % 7 == 0) {
        forecast.clearCheckBalls();
      }
      await forecast.checkBalls();
    }
  }

  _createBalls(List<Ball> list) {
    if (list.length == 0) {
      return Text("");
    }
    List<Widget> widgets = [];
    for (int i = 0; i < list.length; i++) {
      Ball ball = list[i];
      LotteryBall lotteryBall = new LotteryBall(
          color: i < 6 ? Colors.red : Colors.blue, num: ball.num);
      Widget widget = Expanded(
        flex: 1,
        child: lotteryBall,
      );
      widgets.add(widget);
    }
    return new Row(
      children: widgets,
    );
  }

  _getBallList() {
    return ballLists[0].length == 0
        ? new Text("")
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ballLists.length,
            itemBuilder: (BuildContext context, int position) {
              return _createBalls(ballLists[position]);
            });
  }

  _getButton(BallNumButton button, Function tap) {
    return new MaterialButton(
      onPressed: button.enable ? tap : null,
      splashColor: Colors.blue,
      color: Colors.greenAccent,
      disabledColor: Colors.grey,
      child: Text(button.text,
          style: new TextStyle(
              color: Colors.white, fontSize: ScreenUtil().setSp(30))),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shape: CircleBorder(),
    );
  }

  _getMyData() {
    _getMyLotteryData().then((value) {
      if (value == 0) {
        print('获取我的服务器数据成功');
      } else {
        print("获取我的服务器数据失败");
      }
    });
  }

  _getData() {
    // _getLotteryData("ssq", 10, 0);
    _loadData2MyServer();
  }

  _addData() {
    _addLottery2Server().then((value) {
      print(value);
    });
  }

  _loadData2MyServer(){
    print("开始数据迁移操作，页数" + _juHePageIndex.toString());
    _getLotteryData("ssq", _pageCount, _juHePageIndex).then((value) {
      if (value == 0) {
        print("开始上传数据");
        _updateLotteryState("开始上传数据");
        _addLottery2Server().then((value) {
          if (value == 0) {
            _juHePageIndex = _juHePageIndex - 1;
            if (_juHePageIndex > 0) {
              _updateLotteryState("开始获取"+_juHePageIndex.toString()+"页数据");
              Future.delayed(Duration(seconds: 1), () {
                _loadData2MyServer();
              });
            }else{
              _updateLotteryState("数据全部获取并上传完成");
            }
          }else{
            _updateLotteryState("上传数据到我的服务器失败，请检查原因,正在上传页数"+_juHePageIndex.toString());
          }
        });
      } else if (value == 2){
        _loadData2MyServer();
      }else{
        print("获取数据失败");
      }
    });
  }

  Future<int> _addLottery2Server() async {
    for (Lottery lottery in _lotteryList) {
      try {
        Response response = await Dio().post(LOTTERY_SERVER, data: lottery.toJson());
        Map dataMap = jsonDecode(response.toString());
        if (dataMap['ret'] != 1) {
          print("添加失败" + lottery.no);
          return 1;
        }
      } catch (e) {
        print("error=>" + e.toString());
        return 1;
      }
    }

    print("上传数据成功");
    return 0;
  }

  _updateLotteryState(String state) {
    setState(() {
      checkBallState = state;
    });
  }

  Future<int> _getMyLotteryData() async {
    try {
      Response response = await Dio().get(LOTTERY_SERVER);
      Map obj = json.decode(response.toString());
      MyNetLotteryDataEntity entity = MyNetLotteryDataEntity().fromJson(obj);
      if (entity.ret == 1) {
        List<MyNetLotteryDataDatasLottery> lotterys = entity.datas.lottery;
        if (lotterys.isEmpty) {
          print('获取服务器数据成功，但是数量为0');
          _updateLotteryState("无彩票历史数据");
          return 1;
        }
        _updateLotteryState("初始化数据成功,数据量为"+lotterys.length.toString());
        print('获取我的服务器数据成功,总数据量=>' + lotterys.length.toString());
        forecast.initBalls(lotterys);
        return 0;
      }
      _updateLotteryState("初始化数据失败=>ret=" + entity.ret.toString());
    } catch (e) {
      _updateLotteryState("初始化数据失败,获取不到数据");
      return 1;
    }
    _updateLotteryState("初始化彩票数据失败");
    return 1;
  }

  Future<int> _getLotteryData(String type, int size, int pageIndex) async {
    String url = "http://apis.juhe.cn/lottery/history?" +
        "lottery_id=" +
        type +
        "&page_size=" +
        size.toString() +
        "&page=" +
        pageIndex.toString();
    url = url + "&key=4eea0eb5ef2f9c5c756a82aff65a1abb";
    try {
      Response response = await Dio().get(url);
      Map obj = json.decode(response.toString());
      JuHeLotteryEntity entity = JuHeLotteryEntity().fromJson(obj);
      if (entity.errorCode == 0) {
        // 第一遍先确定页数
        if (_juHeTotalPageCount < 0) {
          _juHeTotalPageCount = entity.result.totalPage;
          _juHePageIndex = _juHeTotalPageCount;   // 确定下次获取页数下标
          print("获取数据成功,页数" + _juHePageIndex.toString());
          _updateLotteryState("确定数据页数"+_juHeTotalPageCount.toString());
          return 2;
        }
        List<JuHeLotteryResultLotteryResList> results =
            entity.result.lotteryResList;
        _lotteryList.clear();
        for (JuHeLotteryResultLotteryResList resList in results) {
          Lottery lottery = new Lottery();
          lottery.date = resList.lotteryDate;
          lottery.no = resList.lotteryNo;
          lottery.res = resList.lotteryRes;
          _lotteryList.add(lottery);
        }
        return 0;
      }
    } catch (e) {
      print("获取数据失败" + e.toString());
      return 1;
    }

    return 1;
  }
}
