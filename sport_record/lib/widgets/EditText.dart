import 'package:flutter/material.dart';

class EditText extends StatelessWidget{
  final String hintText;
  final bool autoFocus;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Function onChanged;

  EditText({
    Key key,
    this.hintText,
    this.autoFocus = false,
    this.padding,
    this.margin,
    this.onChanged
});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: margin == null ? EdgeInsets.all(5) : margin,
      padding: padding == null ? EdgeInsets.all(0) : padding,
      child: new TextField(
        autofocus: autoFocus,
        onChanged: (v){
          if (onChanged != null){ onChanged(v);}
        },
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))
        ),
      ),
    );
  }
}