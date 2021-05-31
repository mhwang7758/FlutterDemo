import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        allowFontScaling: false,
        child: MaterialApp(
          title: 'Flutter Demo',
          routes: {
            "Home": (context) => Home(),
          },
          home: Home(),
        ));
  }
}
