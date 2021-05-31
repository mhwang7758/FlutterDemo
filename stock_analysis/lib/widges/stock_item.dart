import 'package:flutter/material.dart';

class StockItem extends StatelessWidget {
  final Color gidColor;
  final Color txtColor;
  final String text;

  final String gid;
  final Function? onClick;

  StockItem(this.gid, this.gidColor, this.text, this.txtColor, {this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick?.call();
        },
        child: new Container(
            // width: 100,
            height: 80,
            margin: EdgeInsets.only(top: 10, left: 5),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                border: new Border.all(
                    width: 1, style: BorderStyle.solid, color: Colors.grey),
                borderRadius: new BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Text(text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: txtColor,
                    )),
                Expanded(
                    child: Text(gid,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: gidColor,
                        )))
              ],
            )));
  }
}
