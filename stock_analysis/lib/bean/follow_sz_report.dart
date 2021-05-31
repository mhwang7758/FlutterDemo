import 'package:stock_analysis/bean/report.dart';

class FollowSZReport extends Report{
  List<double> sz = [];
  List<double> stock = [];
  List<double> diffs = [];
  int state = 0;
  int followDays = 0;
  int unFollowDays = 0;
  String extra = "提供的数据少于分析的天数";
  String type = "从大盘趋势分析:";

  int getTrend(){
    int trend = 0;
    if (unFollowDays <= 0){
      trend = 0;                      // 从不跳水
    }else if (followDays >= unFollowDays){
      if (diffs[diffs.length] >= 0){
        trend = 1;                    // 不跳水次数多于跳水次数且最后一个交易日不跳水
      }else{
        if (diffs[diffs.length - 1] >= 0){
          trend = 2;                  // 不跳水次数多于跳水次数，但是第一个交易日跳水，前一个交易日不跳水
        }else{  // 2天都跳水
          trend = 3;                  // 不跳水次数多于跳水次数，但是第一个交易日跳水，前一个交易日也跳水
        }
      }
    }else if (followDays < unFollowDays){
      if (diffs[diffs.length] >= 0){
        trend = 4;                   // 跳水次数多于不跳水次数，且最后一个交易日不跳水
      }else{
        if (diffs[diffs.length - 1] >= 0){
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
    String? text;
    if (unFollowDays <= 0){
      text = "跟随大盘";
    }else if (followDays > unFollowDays){
      text = "有"+followDays.toString()+"天跟随大盘";
    }else{
      text = "有"+unFollowDays.toString()+"不跟随大盘";
    }
    reports.add(text);

    double maxDiff = diffs[0];
    int index = 0;
    for (int i = 0; i < diffs.length; i++){
      if (maxDiff < diffs[i]){
        maxDiff = diffs[i];
        index = i;
      }
    }
    reports.add("最大偏离值为第"+index.toString()+"交易日,达到"+maxDiff.toString());
    return reports;
  }
}