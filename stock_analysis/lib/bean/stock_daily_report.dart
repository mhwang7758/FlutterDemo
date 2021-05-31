import 'package:stock_analysis/bean/report.dart';

class StockDailyReport extends Report{
  Map<String, double> result = new Map();
  List<double> diffPers = [];
  int state = 0;
  String extra = "提供的数据少于分析的天数";
  int downCounts = 0;   // 跳水数量
  int upCounts = 0;     // 不跳水数量
  String type = "从早上和下午趋势分析:";

  int getTrend(){
    int trend = 0;
    if (downCounts <= 0){
      trend = 0;                      // 从不跳水
    }else if (upCounts >= downCounts){
      if (diffPers[diffPers.length] >= 0){
        trend = 1;                    // 不跳水次数多于跳水次数且最后一个交易日不跳水
      }else{
        if (diffPers[diffPers.length - 1] >= 0){
          trend = 2;                  // 不跳水次数多于跳水次数，但是第一个交易日跳水，前一个交易日不跳水
        }else{  // 2天都跳水
          trend = 3;                  // 不跳水次数多于跳水次数，但是第一个交易日跳水，前一个交易日也跳水
        }
      }
    }else if (upCounts < downCounts){
      if (diffPers[diffPers.length] >= 0){
        trend = 4;                   // 跳水次数多于不跳水次数，且最后一个交易日不跳水
      }else{
        if (diffPers[diffPers.length - 1] >= 0){
          trend = 5;                 // 跳水次数多于不跳水次数，但是第一个交易日跳水，前一个交易日不跳水
        }else{  // 2天都跳水
          trend = 6;                 // 跳水次数多于不跳水次数，但是第一个交易日跳水，前一个交易日也跳水
        }
      }
    }

    return trend;
  }


  @override
  List<String> createReport() {
    List<String> reports = [];
    double maxPer = diffPers[0];
    int maxPerIndex = 0;
    double minPer = diffPers[0];
    int minPerIndex = 0;
    for (int i = 0; i < diffPers.length; i++){
      double per = diffPers[i];
      if (maxPer < per){
        maxPer = per;
        maxPerIndex = i;
      }
      if (minPer > per){
        minPer = per;
        minPerIndex = i;
      }
    }

    String text = "";
    if (downCounts <= 0){
      text="每天下午都比上午高";
    }else if (upCounts <= 0){
      text="每天下午跳水";
    }else if (upCounts > downCounts){
      text="有"+upCounts.toString()+"天下午比上午高";
    }else{
      text="有"+downCounts.toString()+"天跳水";
    }

    reports.add(text);

    text = "相差最大的是第"+maxPerIndex.toString()+"天的"+maxPer.toString();
    reports.add(text);
    text = "相差最小的是第"+minPerIndex.toString()+"天的"+minPer.toString();
    reports.add(text);
    return reports;
  }
}