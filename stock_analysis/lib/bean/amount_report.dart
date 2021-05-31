import 'package:stock_analysis/bean/report.dart';

class AmountReport extends Report{
  String type = "从交易量分析:";
  int state = 0;   // 0为分析失败
  int trend = Report.UN_KNOW;
  Map<String,double> result = new Map();
  String extra = "提供的数据少于分析的天数";
  int downCounts = 0;   // 上涨数量
  int upCounts = 0;     // 下跌数量
  double latestAmountRadio = 0;

  int _getTrend(){
    if (downCounts == 0){
      return Report.UP;
    }else if (upCounts == 0){
      return Report.DOWN;
    }else if (downCounts <= upCounts){
      return Report.UP_THAN_DOWN;
    }else{
      return Report.DOWN_THAN_UP;
    }
  }

  @override
  List<String> createReport(){
    int trend = _getTrend();
    List<String> reports = [];
    String text = "无趋势";
    switch (trend){
      case Report.UP:
        text = "量持续放大"+result.length.toString()+"天,处于上升趋势";
        break;
      case Report.DOWN:
        text = "量持续缩小"+result.length.toString()+"天,处于下跌趋势";
        break;
      case Report.UP_THAN_DOWN:
        text = "交易量放大天数比缩小天数多，整体上是上升";
        // 如果最后一天量比前一天高，则拉升的节奏
        break;
      case Report.DOWN_THAN_UP:
        text = "交易量缩小天数比放大天数多，整体下跌";
        break;
    }
    reports.add(text);

    reports.add("近两日量比为"+latestAmountRadio.toString());
    text = "";
    if (latestAmountRadio > 1.7){
      text += ",量比大于1.7,有出货嫌疑";
    }else if (latestAmountRadio < 0.9){
      text += ",量比比前一日小，持续缩量";
    }
    if (text != ""){
      reports.add(text);
    }

    return reports;
  }

}