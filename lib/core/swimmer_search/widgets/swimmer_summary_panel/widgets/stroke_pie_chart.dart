import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';

class StrokePieChart extends StatelessWidget {
  const StrokePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSwimmerTimesBloc, AllSwimmerTimesState>(
      builder: (context, state) {
        if(state is AllSwimmerTimesFetchSuccessful) {
          final times = state.times;

          // Get the number of occurrences of each stroke type
          final backstrokeCount = times.where((time) => time["stroke"] == "Back").length;
          final breaststrokeCount = times.where((time) => time["stroke"] == "Breast").length;
          final butterflyCount = times.where((time) => time["stroke"] == "Fly").length;
          final freestyleCount = times.where((time) => time["stroke"] == "Free").length;
          final individualMedleyCount = times.where((time) => time["stroke"] == "IM").length;

          // put counts in a list of int
          final Map<String, int> counts = {
            "Back": backstrokeCount,
            "Breast": breaststrokeCount,
            "Fly": butterflyCount,
            "Free": freestyleCount,
            "IM": individualMedleyCount,
          };

          // sort counts map by value
          counts..entries.toList().sort((a, b) => a.value.compareTo(b.value));

          // map countsSorted to list of StrokeChartData with the color as primary[index].
          // Don't include strokes with 0 occurrences.
          final strokeData = counts.entries.where((entry) => entry.value > 0).map((entry) {
            final stroke = entry.key;
            final occurrences = entry.value;
            final color = primary[counts.keys.toList().indexOf(stroke)];
            return StrokeChartData(stroke, occurrences, color);
          }).toList();

          return SfCircularChart(
            annotations: [
              // sum of all occurrences
              CircularChartAnnotation(
                widget: Text("${times.length} Swims",
                  style: TextStyle(
                    color: neutral[3], fontSize: 16),
                ),
              ),
            ],
            series: <CircularSeries>[
              DoughnutSeries<StrokeChartData, String>(
                dataSource: strokeData,
                radius: '90%',
                xValueMapper: (StrokeChartData data, _) => data.stroke,
                yValueMapper: (StrokeChartData data, _) => data.occurrences,
                pointColorMapper: (StrokeChartData data, _) => data.color,
                dataLabelMapper: (StrokeChartData data, _) => "${data.stroke}: ${data.occurrences}",
                animationDuration: 1000,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside,
                  useSeriesColor: true,
                ),
              ),
            ],
          );
        } else {
          return const StrokePieChartEmpty();
        }
      }
    );
  }
}

class StrokePieChartEmpty extends StatelessWidget {
  const StrokePieChartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        DoughnutSeries<StrokeChartData, String>(
          dataSource: [
            StrokeChartData("Back", 1, Colors.grey[100]!),
            StrokeChartData("Breast", 1, Colors.grey[200]!),
            StrokeChartData("Fly", 1, Colors.grey[300]!),
            StrokeChartData("Free", 1, Colors.grey[100]!),
            StrokeChartData("IM", 1, Colors.grey[200]!),
          ],
          radius: '90%',
          xValueMapper: (StrokeChartData data, _) => data.stroke,
          yValueMapper: (StrokeChartData data, _) => data.occurrences,
          pointColorMapper: (StrokeChartData data, _) => data.color,
          dataLabelMapper: (StrokeChartData data, _) => data.stroke,
          animationDuration: 0,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            useSeriesColor: true,
          ),
        ),
      ],
    );
  }
}


class StrokeChartData {
  StrokeChartData(this.stroke, this.occurrences, [this.color = Colors.blue]);
  final String stroke;
  final int occurrences;
  final Color color;
}
