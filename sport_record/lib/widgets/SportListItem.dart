import 'package:flutter/material.dart';

/*
 * 运动类列表控件
 ***/
class SportListItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function onPress;
  final bool finish;
  final String count;

  SportListItem(
      {Key key,
      this.text,
      this.iconPath,
      this.padding,
      this.margin,
        this.count,
        this.finish = false,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border.all(width: 1, color: Colors.grey)
      ),
      margin: margin == null ? const EdgeInsets.only(top: 5) : margin,
      padding: padding == null ? const EdgeInsets.only(top: 10, bottom: 10) : padding,
      child: new Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
//              alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    count == null ? Text("") : Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: new Text(
                        count,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),

                    Expanded(
                      child: new Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400,
                            color: finish ? Colors.green : Colors.black
                        ),
                      ),
                    )


                  ],
                )
              ),
            ),

            Expanded(
              flex: 1,
              child: new Image.asset(
                iconPath,
                width: 64,
                height: 64,
              ),
            ),
          ]

      ),
    );

  }
}
