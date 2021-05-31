import 'package:flutter/material.dart';
import 'package:stock_analysis/bean/follow_sz_report.dart';
import 'package:stock_analysis/bean/report.dart';
import 'package:stock_analysis/bean/stock_daily_report.dart';
import 'package:stock_analysis/entity/shares_entity.dart';
import 'package:stock_analysis/entity/shares_detail_entity.dart';
import 'package:stock_analysis/entity/sz_index_entity.dart';
import 'package:stock_analysis/pages/stock_analysis_report.dart';
import 'package:stock_analysis/widges/stock_item.dart';
import 'package:stock_analysis/util/stock_analysis_util.dart';
import '../bean/stock.dart';
import '../net_util.dart';
import '../bean/amount_report.dart';
import 'package:stock_analysis/bean/price_report.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  static const int ANALYSIS_DAYS = 6;
  List<Stock> stocks = [];

  @override
  void initState() {
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("分析")),
      body: new Container(
        child: new Row(
          children: [
            Expanded(child: _leftPart(), flex: 1),
            // Expanded(child: _rightPart(), flex: 1)
          ],
        ),
      ),
    );
  }

  PriceReport? _priceAnalysis(List<SharesDetailBean> beans) {
    PriceReport report =
        StockAnalysisUtil.analysisPriceTrend(beans, ANALYSIS_DAYS);
    if (report.state == 0) {
      print(report.extra);
      return null;
    }
    print(report.createReport());
    return report;
  }

  AmountReport? _amountAnalysis(List<SharesDetailBean> beans) {
    AmountReport amountReport =
        StockAnalysisUtil.analysisAmountTrend(beans, ANALYSIS_DAYS);
    if (amountReport.state == 0) {
      print(amountReport.extra);
      return null;
    }
    print(amountReport.createReport());
    return amountReport;
  }

  StockDailyReport? _stockDailyAnalysis(List<SharesDetailBean> beans) {
    StockDailyReport report =
        StockAnalysisUtil.analysisDailyPriceTrend(beans, ANALYSIS_DAYS);
    if (report.state == 0) {
      print(report.extra);
      return null;
    }
    print(report.createReport());
    return report;
  }

  // todo 暂时没想到要怎么解决，后续
  _followSZAnalysis(List<SharesDetailBean> beans) {
    NetUtil().getSZIndex().then((value) {
      if ("".endsWith(value)) {
        print("请求出错");
        return;
      }
      Map<String, dynamic> obj = json.decode(value);

      SzIndexEntity entity = SzIndexEntity.fromMap(obj);

      List<SZIndexBean> iBeans = entity.datas.beans;
      FollowSZReport report =
          StockAnalysisUtil.analysisFollowSZ(iBeans, beans, 4);
      if (report.state == 0) {
        print(report.extra);
        return;
      }
      print(report.createReport());
    });
  }

  _getStockDetail(String gid) {
    new NetUtil().getStockDetail(gid).then((value) {
      if ("".endsWith(value)) {
        print("_getStockDetail->请求出错");
        return;
      }

      Map<String, dynamic> obj = json.decode(value);

      SharesDetailEntity entity = SharesDetailEntity.fromMap(obj);

      List<SharesDetailBean> beans = entity.datas.sharesDetail;

      // 价格分析
      _priceAnalysis(beans);
      // 交易量分析
      _amountAnalysis(beans);
      // 跟随上证分析
      _followSZAnalysis(beans);
      // 交易日纵向分析
      _stockDailyAnalysis(beans);

      // 开始分析
      // setState(() {});
    });
  }

  _initData() {
    new NetUtil().getStocks().then((value) {
      if ("".endsWith(value)) {
        print("请求出错");
        return;
      }

      Map<String, dynamic> obj = json.decode(value);

      ShareEntity entity = ShareEntity.fromMap(obj);

      List<SharesBean> beans = entity.datas.shares;

      for (SharesBean bean in beans) {
        String name = bean.name;
        String gid = bean.gid;
        Stock stock = new Stock(gid, name);
        stocks.add(stock);
      }
      setState(() {});
    });
    // for (int i = 0; i < 5; i++){
    //   Stock stock = new Stock("name", "sz002166");
    //   stocks.add(stock);
    // }
  }

  _leftPart() {
    return new Column(children: [
      Expanded(
        flex: 5,
        child: stocks.length == 0
            ? new Text("没有数据")
            : ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (BuildContext context, int position) {
                  return StockItem(stocks[position].gid, Colors.red,
                      stocks[position].name, Colors.blue, onClick: (){
                        _toAnalysisReport(stocks[position]);
                      });
                }),
      ),
      Expanded(
        flex: 2,
        child: MaterialButton(
          onPressed: _onAnalysisAllStocks,
          splashColor: Colors.blue,
          color: Colors.greenAccent,
          disabledColor: Colors.grey,
          child: Text("分析",
              style: new TextStyle(color: Colors.white, fontSize: 30)),
          shape: CircleBorder(),
        ),
      )
    ]);
  }

  _toAnalysisReport(Stock stock){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return StockAnalysisReport(stock);
    }));
  }

  _onAnalysisAllStocks(){
    for (Stock stock in this.stocks){
      _analysis(stock);
    }
  }

  _analysis(Stock stock) {
    // _getStockDetail(stock.gid);
    print("开始分析"+stock.gid);
    new NetUtil().getStockDetail(stock.gid).then((value) {
      if ("".endsWith(value)) {
        print("_getStockDetail->请求出错");
        return;
      }

      Map<String, dynamic> obj = json.decode(value);

      SharesDetailEntity entity = SharesDetailEntity.fromMap(obj);

      List<SharesDetailBean> beans = entity.datas.sharesDetail;

      // 价格分析
      PriceReport? priceReport = _priceAnalysis(beans);
      if (priceReport != null){
        stock.priceReport = priceReport;
      }
      // 交易量分析
      AmountReport? amountReport = _amountAnalysis(beans);
      if (amountReport != null){
        stock.amountReport = amountReport;
      }
      // 交易日纵向分析
      StockDailyReport? stockDailyReport = _stockDailyAnalysis(beans);
      if (stockDailyReport != null){
        stock.stockDailyReport = stockDailyReport;
      }
      // 跟随上证分析
      _followSZAnalysis(beans);

      // 综合分析


      // 开始分析
      // setState(() {});
    });
  }

  _analysisSummary(Stock stock){
    PriceReport? priceReport = stock.priceReport;
    AmountReport? amountReport = stock.amountReport;
    StockDailyReport? dailyReport = stock.stockDailyReport;
    FollowSZReport? followSZReport = stock.followSZReport;
    List<String> summary = [];
    double score = 0.0;
    if (priceReport != null && amountReport != null
        && dailyReport != null){
      switch(priceReport.trend){
        case Report.UP:
          List<double> prices = priceReport.result.values.toList();
          double lastDiff = prices[prices.length - 1] - prices[prices.length - 2];
          if (lastDiff >= 0){
            summary.add("金额涨幅逐渐加大");
            score += 10;
          }else {
            summary.add("金额涨幅逐渐减小");
            score -= 10;
          }
          switch(amountReport.trend){
            case Report.UP:
              break;
            case Report.DOWN:
              break;
            case Report.DOWN_THAN_UP:
              break;
            case Report.UP_THAN_DOWN:
              break;
          }
          break;
      }
    }
}

  _fromAmount(AmountReport amountReport, StockDailyReport dailyReport, FollowSZReport followSZReport){
    int result;
    switch(amountReport.trend){
      case Report.UP:
        break;
      case Report.DOWN:
        break;
      case Report.DOWN_THAN_UP:
        break;
      case Report.UP_THAN_DOWN:
        break;
    }
  }

  _fromDaily(StockDailyReport dailyReport, FollowSZReport followSZReport){
    switch(dailyReport.getTrend()){
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;

    }
  }

  _rightPart() {
    return new Container();
  }

}
