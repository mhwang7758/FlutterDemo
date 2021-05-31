import 'package:stock_analysis/bean/amount_report.dart';
import 'package:stock_analysis/bean/stock_daily_report.dart';
import 'package:stock_analysis/entity/shares_detail_entity.dart';
import 'package:stock_analysis/bean/price_report.dart';
import 'package:stock_analysis/bean/follow_sz_report.dart';
import 'package:stock_analysis/entity/sz_index_entity.dart';

class StockAnalysisUtil{
  static const int GET_DATA_COUNTS = 2;

  static bool canAnalysis(List<SharesDetailBean> data, int days){
    int tradeDays = (data.length / GET_DATA_COUNTS).truncate();
    return tradeDays >= days;
  }

  static List<SharesDetailBean>? getFitList(List<SharesDetailBean> data, int days){
    int tradeDays = (data.length / GET_DATA_COUNTS).truncate();
    List<SharesDetailBean> result;
    if (tradeDays < days){
      return null;
    }
    result = [];
    int counts = days * GET_DATA_COUNTS;
    for (int i = data.length - 1; i >= 0; i--){
      result.add(data[i]);
      counts--;
      if (counts <= 0){
        break;
      }
    }
  }

  static List<SharesDetailBean> getListAfterTradeOver(List<SharesDetailBean> data, int days){
    List<SharesDetailBean> result = [];
    for (int i = data.length - 1; i - GET_DATA_COUNTS >= 0; i--){
      result.add(data[i]);
    }
    return result;
  }

  /*
   * 分析给定交易日的趋势
   * */
  static PriceReport analysisPriceTrend(List<SharesDetailBean> data, int days){
    PriceReport report = new PriceReport();
    List<SharesDetailBean>? fitData = getFitList(data, days);
    if (fitData == null){
      return report;
    }

    fitData = getListAfterTradeOver(fitData, days);

    int count = 0;
    double startPrice = double.parse(fitData[0].nowPri);
    double minPrice = double.parse(fitData[0].nowPri);
    int minPriceIndex = 0;
    for (int i = 0 ; i + 1 < fitData.length; i++){
      SharesDetailBean bean = fitData[i];
      SharesDetailBean lastBean = fitData[i + 1];
      double price = double.parse(bean.nowPri);
      double lastPrice = double.parse(lastBean.nowPri);
      if (lastPrice < minPrice){
        minPrice = lastPrice;
        minPriceIndex = i;
      }
      count++;
      print("当前交易日："+price.toString()+" 前一个交易日："+lastPrice.toString());
      String date = bean.date;
      double diffPrice = price - lastPrice;
      if (diffPrice >= 0){
        report.upCounts++;
      }else{
        report.downCounts++;
      }
      report.result[date] = diffPrice;

      if (count == days - 1){
        report.state = 1;
        report.priceDiff = price - startPrice;
        break;
      }
    }
    return report;
  }

  static StockDailyReport analysisDailyPriceTrend(List<SharesDetailBean> data,int days){
    StockDailyReport report = new StockDailyReport();
    if (!canAnalysis(data, days)){
      return report;
    }

    int count = 0;
    for (int i = 0; i + 1 < data.length - 1; i++){
      count++;
      SharesDetailBean bean = data[i];
      SharesDetailBean nextBean = data[i + 1];
      double per = double.parse(bean.increPer);
      double nextPer = double.parse(nextBean.increPer);
      double diff = nextPer - per;
      String date = nextBean.date;
      if (diff >= 0){
        report.upCounts++;
      }else {
        report.downCounts++;
      }
      report.result[date] = diff;
      report.diffPers.add(diff);

      if (count == days - 1){
        report.state = 1;
        break;
      }
    }
    return report;
  }

  /* 交易量的变化趋势
  * **/
  static AmountReport analysisAmountTrend(List<SharesDetailBean> data, int days){
    AmountReport report = new AmountReport();
    if (!canAnalysis(data, days)){
      return report;
    }

    int count = 0;
    for (int i = 1 ; i + GET_DATA_COUNTS <= data.length - 1; i = i + GET_DATA_COUNTS){
      SharesDetailBean bean = data[i];
      SharesDetailBean nextBean = data[i + GET_DATA_COUNTS];
      double amount = double.parse(bean.traAmount);
      double nextAmount = double.parse(nextBean.traAmount);
      count++;
      double radio = nextAmount / amount;
      if (radio >= 1){
        report.upCounts++;
      }else{
        report.downCounts++;
      }
      report.result[nextBean.date] = radio;

      if (count == days - 1){
        report.state = 1;
        report.latestAmountRadio = radio;
        break;
      }
    }
    return report;
  }

  static FollowSZReport analysisFollowSZ(List<SZIndexBean> iBeans, List<SharesDetailBean> data, int days){
    FollowSZReport report = new FollowSZReport();
    if (!canAnalysis(data, days)){
      return report;
    }

    int count = 0;
    for (int i = 1 ; i + GET_DATA_COUNTS <= data.length - 1; i = i + GET_DATA_COUNTS){
      count++;
      SZIndexBean indexBean = iBeans[i];
      SharesDetailBean bean = data[i];
      double szIncrePer = double.parse(indexBean.increPer);
      double stockIncrePer = double.parse(bean.increPer);
      report.sz.add(szIncrePer);
      report.stock.add(stockIncrePer);

      report.diffs.add((stockIncrePer - szIncrePer).abs());

      if (szIncrePer <= 0 && stockIncrePer <= 0
          || (szIncrePer > 0 && stockIncrePer > 0)){
        report.followDays++;
      }else{
        report.unFollowDays++;
      }

      if (count == days - 1){
        report.state = 1;
        break;
      }
    }

    return report;
  }

}