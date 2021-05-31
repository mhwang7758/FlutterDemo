import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_analysis/util/chart_helper.dart';

class StockReportItem extends StatelessWidget {
  final String type;
  final List<String> reports;
  final Map<String, double>? results;
  static int touchedIndex = -1;
  final Function? touchCallback;

  StockReportItem(this.type, this.reports, {this.results, this.touchCallback});

  _getListViewItem(String text) {
    return new Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.centerLeft,
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          border: new Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.yellow),
          borderRadius: new BorderRadius.all(Radius.circular(5))),
      constraints: BoxConstraints(minHeight: 40),
      // 设置最小高度
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          )),
    );
  }

  _getList() {
    return Container(
      alignment: Alignment.center,
      color: Colors.green,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: reports.length,
          itemBuilder: (BuildContext context, int position) {
            return _getListViewItem(reports[position]);
          }),
    );
  }

  _getChart() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      color: Colors.blue,
      child: BarChart(
          mainBarData(results ?? new Map<String, double>(), touchCallback)),
    );
  }

  BarChartData mainBarData(Map<String, double> data, callback) {
    return BarChartData(
      // alignment: BarChartAlignment.center,   居中显示，并调整间距
      // groupsSpace: 10,
      minY: -0.5,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = data.keys.toList()[group.x.toInt()];
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          callback?.call(barTouchResponse);
          // setState(() {
          //   if (barTouchResponse.spot != null &&
          //       barTouchResponse.touchInput is! PointerUpEvent &&
          //       barTouchResponse.touchInput is! PointerExitEvent) {
          //     touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          //   } else {
          //     touchedIndex = -1;
          //   }
          // });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 5,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: ChartHelper.showingGroups(data.values.toList().length, data),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(reports.length);
    return new Container(
      height: 300,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      alignment: Alignment.center,
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          border: new Border.all(
              width: 1, style: BorderStyle.solid, color: Colors.grey),
          borderRadius: new BorderRadius.all(Radius.circular(10))),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(type,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: _getChart(),
                  ),
                  Expanded(flex: 1, child: _getList())
                ],
              ))
        ],
      ),
    );
  }
}
