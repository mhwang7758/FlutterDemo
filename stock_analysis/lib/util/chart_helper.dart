import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartHelper {
  static BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.green,
    double width = 22,
    double max = 2,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: y > 0 ? [Colors.red] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: max,
            colors: [Colors.yellow],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  static List<BarChartGroupData> showingGroups(
      int length, Map<String, double> data) {
    List<double> results = data.values.toList();
    double max = 0.0;
    for (double d in results){
      if (max < d){
        max = d;
      }
    }
    if (max <= 0) max = 1;
    return List.generate(length, (i) {
      return makeGroupData(i, results[i], isTouched: true, max: max);
    });
  }
}
