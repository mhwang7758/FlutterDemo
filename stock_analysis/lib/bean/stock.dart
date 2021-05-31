import '../bean/amount_report.dart';
import '../bean/follow_sz_report.dart';
import '../bean/price_report.dart';
import '../bean/stock_daily_report.dart';
class Stock{
  String gid;
  String name;
  double? score;
  List<String>? report;

  AmountReport? amountReport;
  FollowSZReport? followSZReport;
  PriceReport? priceReport;
  StockDailyReport? stockDailyReport;

  Stock(this.gid, this.name, {this.amountReport, this.followSZReport,
      this.priceReport, this.stockDailyReport, this.score, this.report});
}