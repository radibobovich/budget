import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/stats/domain/chart_segment.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartSegment;

class Chart extends StatelessWidget {
  const Chart(
      {super.key,
      required this.segments,
      required this.totalValue,
      required this.isIncome});
  final List<ChartSegment> segments;
  final int totalValue;
  final bool isIncome;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.window.width * 0.5,
      height: context.window.width * 0.5,
      child: SfCircularChart(
        margin: const EdgeInsets.all(0),
        series: [
          DoughnutSeries<ChartSegment, String>(
            xValueMapper: (segment, _) => '',
            yValueMapper: (segment, _) => totalValue != 0
                ? (segment.valueKopecks / totalValue).clamp(0, 1)
                : 0,
            pointColorMapper: (segment, _) =>
                segment.color ?? context.theme.cardColor,
            dataSource: segments,
            radius: '90%',
            innerRadius: '60%',
            animationDuration: 200,
          )
        ],
        annotations: [
          CircularChartAnnotation(
              widget: Icon(
            isIncome ? Icons.download : Icons.upload,
            size: context.window.width * 0.15,
            color: isIncome
                ? context.colors.incomeGradient.colors.first
                : context.colors.expenseGradient.colors.first,
          ))
        ],
      ),
    );
  }
}
