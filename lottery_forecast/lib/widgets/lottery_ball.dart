import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LotteryBall extends StatelessWidget {
  final Color color;
  final int num;
  final EdgeInsets margin;

  LotteryBall({Key key, this.color, this.num, this.margin});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      margin: margin == null ? EdgeInsets.only(left: ScreenUtil().setWidth(5)) : margin,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(width: 6, color: color)
      ),
      child: Text(num < 10 ? "0"+num.toString(): num.toString(),
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: ScreenUtil().setSp(15)
      ),),
    );
  }
}
