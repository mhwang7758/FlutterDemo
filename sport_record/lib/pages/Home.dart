import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sport_record/util/NativeCache.dart';
import 'package:sport_record/widgets/EditText.dart';
import 'package:sport_record/widgets/SportListItem.dart';

import '../Sport.dart';
import '../gym_plan_entity.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<Sport> sports = [];

  Future<String> future;
  String uId;
  Map<String, int> countsMap = new Map();
  var sportName;
  var sportTime;

  @override
  void initState() {
    super.initState();

    initUid();

    NativeCache.getData("map").then((value) {
      if (value == null) return;
      print("countsmap=>" + value.toString());
      try {
        countsMap = json.decode(value);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return new Scaffold(
        appBar: new AppBar(
//        title: new Text(_getDate()),
          title: new Text(uId == null ? "null" : uId),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            OutlineButton.icon(
                onPressed: _toAddSport, icon: Icon(Icons.add), label: Text(""))
          ],
        ),
        body: _getListLayout());
  }

  initUid() async{
    // 获取UID
    await NativeCache.getData(NativeCache.USER_ID).then((value) {
      print("get uid=>"+value.toString());
      if (value == null){
        _toRegister();
      }else{
        uId = value.toString();
        _initListData(uId);
      }

    });

  }

  _toRegister() {
    Navigator.of(context)
        .pushNamed('register')
        .then((value) => _handleRegisterBack(value));
  }

  _handleRegisterBack(value){
    if (value != null) {
      uId = value.toString();
      _initListData(value.toString());
    }
  }

  _getDate() {
    var now = new DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String day = now.day.toString();

    String title = year + "年" + month + "月" + day + "日";
    return title;
  }

  _getListLayout() {
    print("getListLayout" + "sports length " + sports.length.toString());
    return sports.length > 0
        ? new ListView.builder(
            itemCount: sports.length,
            itemBuilder: (BuildContext context, int position) {
              return _getSlidableItem(position);
            })
        : _getEmptyListViewLayout();
  }

  _getEmptyListViewLayout() {
    return new Container(
      margin: EdgeInsets.only(top: 20),
      child: new Row(
        children: <Widget>[
          new Text(
            "没有数据噢",
            style: new TextStyle(fontSize: 30, color: Colors.black),
          ),
          new RaisedButton(
            onPressed: _addSport2Server,
            color: Colors.green,
            child: new Text("去添加"),
          )
        ],
      ),
    );
  }

  _initListData(String uId) async {
    print("initListData");
    sports.clear();
    try {
      Response response = await Dio().get("https://www.52code.tech/gymplan/"+uId);
      Map dataMap = json.decode(response.toString());
      GymPlanEntity data = new GymPlanEntity.fromJson(dataMap);

      List<GymPlanDatasPlan> plans = data.datas.plans;
      for (GymPlanDatasPlan plan in plans) {
        Sport sport = new Sport();
        sport.setId(plan.id);
        sport.setName(plan.title);
        sport.setTime(plan.time);
        sports.add(sport);
      }

      print("initListData sport length " + sports.length.toString());
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  _toAddSport() {
//    Navigator.of(context).pushNamed('addSport');
    _showBottomAddSheet();
  }

  Future<int> _showBottomAddSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return new SingleChildScrollView(
            child: new Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: new Column(
                children: <Widget>[
                  _getAddSportTitle(),
                  _getAddSportInput(),
                  _getAddSportTimeInput(),
                  _getAddSportButton("添加", _addSport2Server)
                ],
              ),
            ),
          );
        });
  }

  _getAddSportTitle() {
    return new Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: new Text("添加运动",
          style: new TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }

  /*
   * 获取添加运动输入框
   * */
  _getAddSportInput() {
    return EditText(
        hintText: "输入运动名称",
        autoFocus: true,
        margin: EdgeInsets.all(5),
        onChanged: (v) {
          sportName = v;
        });
  }

  _getAddSportTimeInput() {
    return EditText(
        hintText: "输入运动时间(分钟)",
        autoFocus: true,
        margin: EdgeInsets.all(5),
        onChanged: (v) {
          sportTime = v;
        });
  }

  _getAddSportButton(String title, Function function) {
    return new Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: new RaisedButton(
        padding: EdgeInsets.only(left: 40, top: 5, right: 40, bottom: 5),
        onPressed: function,
        color: Colors.green,
        child: Text(
          title,
          style: new TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  _addSport2Server() async {
    showLoadingDialog();
    // 添加到服务器
    GymPlanDatasPlan plan = new GymPlanDatasPlan();
    plan.uId = uId;
    plan.title = sportName;
    plan.time = int.parse(sportTime);
    try {
      Response response = await Dio()
          .post("https://www.52code.tech/gymplan", data: plan.toJson());
      print("_addSport2Server back=>" + response.toString());
      Map dataMap = jsonDecode(response.toString());
      if (dataMap['ret'] == 1) {
        if (dataMap['datas'] == null){
          print("_addSport2Server=>return data is null");
          return;
        }
//        Map planMap = json.decode(dataMap["datas"]);
        Sport newSport = new Sport();
        newSport.setTime(sportTime);
        newSport.setName(sportName);
        print("add plan id=>"+dataMap["datas"]);
        sports.add(newSport);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print("error=>"+e.toString());
    }
  }

  _handleSportRunningBack(int id) {
    int count = countsMap[id.toString()];

    print("_handleSportRunningBack count->" + count.toString());
    if (count == null) {
      count = 1;
    } else {
      count = count + 1;
    }

    countsMap.putIfAbsent(id.toString(), () => count);

    NativeCache.setData("map", countsMap.toString());
    print("set countsmap=>" + countsMap.toString());

    Sport sport;
    for (Sport s in sports) {
      if (s.getId() == id) {
        sport = s;
      }
    }
    sport.setFinish(true);
    setState(() {});
  }

  _showDeleteButton(int i, bool delete) {
    Sport sport = sports[i];
    sport.setDelete(delete);
    setState(() {});
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  _deleteSport(int i) async {
    Sport sport = sports[i];
    try {
      String url = "https://www.52code.tech/gymplan/" +
          uId +
          "/" +
          sport.getId().toString();
      Response response = await Dio().delete(url);
      print("_deleteSport back=>" + response.toString());
      Map dataMap = json.decode(response.toString());
      if (dataMap['ret'] == 1) {
        // todo
        Future.delayed(Duration(milliseconds: 200)).then((value) => {
              setState(() {
                sports.removeAt(i);
              })
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _getSlidableItem(int i) {
    String image =
        sports[i].isFinish() ? "images/finish.png" : "images/unfinish.png";
    int count = countsMap[sports[i].getId().toString()];

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      // 滑出面板动画
      actionExtentRatio: 0.25,
      key: Key(sports[i].getId().toString()),
      child: new GestureDetector(
        child: SportListItem(
          text: sports[i].getName(),
          iconPath: image,
          count: count == null ? count : count.toString(),
        ),
        onTap: () {
          Sport sport = sports[i];
          Navigator.of(context)
              .pushNamed('sportRunning', arguments: sport)
              .then((value) =>
                  {if (value != null) _handleSportRunningBack(value)});
        },
      ),

      secondaryActions: <Widget>[
        new Container(
          margin: const EdgeInsets.only(top: 5),
          child: IconSlideAction(
            caption: "删除",
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: () => _deleteSport(i),
          ),
        )
      ],

      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onWillDismiss: (actionType) {
          return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("提示"),
                  content: Text("确定删除此条记录"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("取消"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    FlatButton(
                      child: Text("确定"),
                      onPressed: () {
                        _deleteSport(i);
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        onDismissed: (actionType) {
//            _deleteSport(i);
        },
      ),
    );
  }

  Widget getRow2(int i) {
    return _getSlidableItem(i);
  }

  Row getItem(String icon, Sport sport) {
    return new Row(children: <Widget>[
      Expanded(
        flex: 3,
        child: Container(
          margin: const EdgeInsets.only(left: 30),
//              alignment: Alignment.center,
          child: new Text(
            sport.getName(),
            style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                color: sport.isFinish() ? Colors.green : Colors.black),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: new Image.asset(
          icon,
          width: 64,
          height: 64,
        ),
      ),
    ]);
  }

  _getDeleteButton() {
    return new Container(
      height: 100,
      color: Colors.red,
      child: new RaisedButton(
        onPressed: null,
        child: Text("删除"),
      ),
    );
  }
}
