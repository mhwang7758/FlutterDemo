import 'package:flutter/material.dart';
import 'package:sport_record/util/NativeCache.dart';
import 'package:sport_record/widgets/EditText.dart';
import 'Home.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegisterState();
  }
}

class RegisterState extends State<Register> {
  String uId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: _getRegisterLayout(),
    );
  }

  _getRegisterLayout() {
    return new Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: new Column(
          children: <Widget>[
            EditText(
                hintText: "输入你想要的号码",
                autoFocus: true,
                onChanged: (v) {
                  uId = v;
                }),
            _getAddSportButton("注册")
          ],
        ));
  }

  _getAddSportButton(String title) {
    return new Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: new RaisedButton(
        padding: EdgeInsets.only(left: 40, top: 5, right: 40, bottom: 5),
        onPressed: _register,
        color: Colors.green,
        child: Text(
          title,
          style: new TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  _register() {
    NativeCache.setData(NativeCache.USER_ID, uId);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Home(id: uId,)));
  }
}
