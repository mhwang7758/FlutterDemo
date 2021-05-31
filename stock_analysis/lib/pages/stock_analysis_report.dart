import 'package:flutter/material.dart';
import 'package:stock_analysis/widges/stock_report_item.dart';
import '../bean/stock.dart';
class StockAnalysisReport extends StatefulWidget {
  final Stock stock;

  StockAnalysisReport(this.stock);

  @override
  State<StatefulWidget> createState() {
    return StockAnalysisReportState();
  }
}

class StockAnalysisReportState extends State<StockAnalysisReport> {
  late Stock mStock;
  @override
  void initState() {
    mStock = this.widget.stock;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("详情")),
      body: new Container(
        child: ListView(
              children: [
                StockReportItem(mStock.amountReport!.type, mStock.amountReport!.createReport(),
                    results: mStock.amountReport!.result),
                StockReportItem(mStock.priceReport!.type, mStock.priceReport!.createReport(),
                    results: mStock.priceReport!.result),
                StockReportItem(mStock.stockDailyReport!.type, mStock.stockDailyReport!.createReport(),
                    results: mStock.stockDailyReport!.result),
                // StockReportItem(mStock.followSZReport!.type, mStock.followSZReport!.createReport())
              ],
            ),

      ),
    );
  }
}