import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsWidget extends StatelessWidget {
  final double start;
  final double second;
  final double third;
  final double fourth;
  final double fith;
  final double width;
  final Color? chartCOlor;
  const ChartsWidget({super.key, required this.start, 
  required this.second, required this.third, 
  required this.fourth, required this.fith, this.chartCOlor, required this.width});

  @override
  Widget build(BuildContext context) {
     final List<ChartData> chartData = [
            ChartData(2010, start),
            ChartData(2011, second),
            ChartData(2012, third),
            ChartData(2013, fourth),
            ChartData(2014, fith),
        ];
    return  SfCartesianChart(
                                plotAreaBorderWidth: 0,
                          primaryXAxis: const NumericAxis(
                            labelStyle: TextStyle(color: Colors.transparent), 
                          axisLine: AxisLine(color: Colors.transparent),
                              majorTickLines: MajorTickLines(size: 0), 
                               majorGridLines: MajorGridLines(width: 0), // Hides bottom ticks
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                          ),
                          primaryYAxis: const NumericAxis(
                            labelStyle: TextStyle(color: Colors.transparent), // Hides left labels
                            majorTickLines: MajorTickLines(size: 0), // Hides left ticks
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                             majorGridLines: MajorGridLines(width: 0), 
                            axisLine: AxisLine(color: Colors.transparent),
                          ),
                                  series: <CartesianSeries>[
                                      // Renders spline chart
                                      SplineSeries<ChartData, int>(
                                        color: chartCOlor,
                                        width: width,
                                        splineType: SplineType.cardinal,
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y
                                          )
                                      ]
                                  );
  }
}

  class ChartData {
        ChartData(this.x, this.y);
        final int x;
        final double? y;
    }