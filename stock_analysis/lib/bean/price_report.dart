import 'report.dart';
class PriceReport extends Report{

  int state = 0;   // 0为分析失败
  int trend = Report.UN_KNOW;
  Map<String, double> result = new Map();
  Map<String, double> increPers = new Map();
  double chance = 0;
  String extra = "提供的数据少于分析的天数";
  int downCounts = 0;   // 上涨数量
  int upCounts = 0;     // 下跌数量
  double priceDiff = 0;
  String type = "从金额分析:";

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
    List<String> reports = [];
    int trend = _getTrend();
    String text = "无趋势分析";
    switch (trend){
      case Report.UP:
        text = "连涨"+result.length.toString()+"天,处于上升趋势";
        break;
      case Report.DOWN:
        text = "连跌"+result.length.toString()+"天,处于下跌趋势";
        break;
      case Report.UP_THAN_DOWN:
        text = "上涨数量为"+upCounts.toString()+",比下跌多，整体上是上升";
        break;
      case Report.DOWN_THAN_UP:
        text = "下跌数量为+"+downCounts.toString()+"比上升多，整体下跌";
        break;
    }
    reports.add(text);

    text = priceDiff >= 0 ? "给定交易日内总体上涨":"总体下跌";
    reports.add(text);

    return reports;
  }

}