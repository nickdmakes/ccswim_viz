import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';
import '../../../util/times_data_manager.dart';

class SingleEventGraph extends StatelessWidget {
  const SingleEventGraph({
    required this.times,
    super.key,
  });

  final List<dynamic> times;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTimeBloc, SelectedTimeState>(
      builder: (context, state) {
        if(state is SelectedTimeSelected) {
          final timeManager = TimesDataManager(times: List<Map<String, dynamic>>.from(times));
          timeManager.filterByStroke(state.stroke);
          timeManager.filterByDistance(state.distance);

          final filteredTimes = timeManager.getTimes().reversed.toList();

          // map the filteredTimes to a list of EventTimeData objects
          final List<EventTimeData> eventTimeData = [];
          final DateFormat formatter = DateFormat("MM/dd/yyyy");
          for (int i = 0; i < filteredTimes.length; i++) {
            eventTimeData.add(EventTimeData(
              date: formatter.parse(filteredTimes[i]["date"]),
              time: timeManager.timeStrToDuration(filteredTimes[i]["time"]),
              location: filteredTimes[i]["location"],
              distance: filteredTimes[i]["distance"].toString(),
              stroke: filteredTimes[i]["stroke"],
            ));
          }

          // get time sorted version of eventTimeData and calculate 10% of the time range. Used for setting the y-axis range
          final List<Duration> timesSortedByDuration = eventTimeData.map((e) => e.time).toList()..sort();
          final Duration timeRange = timesSortedByDuration.last - timesSortedByDuration.first;
          Duration timeRange10Percent = Duration(milliseconds: (timeRange.inMilliseconds * 0.1).toInt());
          if(timeRange10Percent.inMilliseconds == 0) {
            timeRange10Percent = const Duration(milliseconds: 1000);
          }

          // get range of dates for x-axis and calculate 5% of the date range. Used for setting the x-axis range
          final DateTime dateRangeStart = eventTimeData.first.date;
          final DateTime dateRangeEnd = eventTimeData.last.date;
          final Duration dateRange = dateRangeEnd.difference(dateRangeStart);

          final primaryXAxis = getDateTimeAxis(eventTimeData, dateRange.inDays);

          final trackballBehavior = TrackballBehavior(
            builder: (BuildContext context, TrackballDetails trackballDetails) {
              final DateTime date = trackballDetails.point!.x as DateTime;
              final Duration time = Duration(milliseconds: trackballDetails.point!.y);
              final String formattedDate = DateFormat("MM/dd/yyyy").format(date);
              // round milliseconds to nearest 0.01 seconds
              final roundedDuration = Duration(milliseconds: (time.inMilliseconds / 10).round() * 10);
              // Get string representation of the duration
              final String formattedTime = "${roundedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${roundedDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}.${(roundedDuration.inMilliseconds.remainder(1000) / 10).round().toString().padLeft(2, '0')}";



              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
            enable: true,
            shouldAlwaysShow: true,
            lineDashArray: const [5, 5],
            lineColor: secondary[2],
            lineWidth: 1,
            lineType: TrackballLineType.vertical,
            activationMode: ActivationMode.singleTap,
            tooltipAlignment: ChartAlignment.center,
          );

          return SfCartesianChart(
            trackballBehavior: trackballBehavior,
            primaryXAxis: primaryXAxis,
            primaryYAxis: NumericAxis(
              isVisible: false,
              maximum: (timesSortedByDuration.last + timeRange10Percent).inMilliseconds.toDouble(),
              minimum: (timesSortedByDuration.first - timeRange10Percent).inMilliseconds.toDouble(),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
            ),
            series: <ChartSeries<EventTimeData, DateTime>>[
              LineSeries<EventTimeData, DateTime>(
                dataSource: eventTimeData,
                dashArray: const [5, 5],
                xValueMapper: (EventTimeData event, _) => event.date,
                yValueMapper: (EventTimeData event, _) => event.time.inMilliseconds,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                  labelAlignment: ChartDataLabelAlignment.top,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                markerSettings: MarkerSettings(
                  isVisible: true,
                  color: primary[2],
                  width: 8,
                  height: 8,
                ),
              ),
            ],
          );
        } else {
          return const SingleEventGraphEmpty();
        }
      }
    );
  }

  DateTimeAxis getDateTimeAxis(List<EventTimeData> eventTimeData, int dateRangeInDays) {
    final firstYear = eventTimeData.first.date.year;
    final lastYear = eventTimeData.last.date.year;
    final firstMonth = eventTimeData.first.date.month;
    final lastMonth = eventTimeData.last.date.month;

    if (dateRangeInDays < 365) {
      return DateTimeAxis(
        dateFormat: DateFormat.yMMM(),
        interval: dateRangeInDays <= 31 ? 1 : 2,
        minimum: DateTime(
          firstYear,
          firstMonth,
        ),
        maximum: DateTime(
          lastYear,
          lastMonth + 1,
        ),
        intervalType: DateTimeIntervalType.months,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      );
    } else {
      return DateTimeAxis(
        dateFormat: DateFormat.y(),
        interval: dateRangeInDays <= 2920 ? 1 : 2,
        minimum: DateTime(firstYear),
        maximum: DateTime(lastYear + 1),
        intervalType: DateTimeIntervalType.years,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      );
    }
  }
}

class SingleEventGraphEmpty extends StatelessWidget {
  const SingleEventGraphEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    // mock data for testing
    final eventTimeData = [
      EventTimeData(date: DateTime(2017, 1), time: const Duration(seconds: 1), location: "location", distance: "50", stroke: "stroke"),
      EventTimeData(date: DateTime(2018, 1), time: const Duration(seconds: 8), location: "location", distance: "50", stroke: "stroke"),
      EventTimeData(date: DateTime(2020, 1), time: const Duration(seconds: 4), location: "location", distance: "50", stroke: "stroke"),
      EventTimeData(date: DateTime(2021, 1), time: const Duration(seconds: 5), location: "location", distance: "50", stroke: "stroke"),
      EventTimeData(date: DateTime(2022, 1), time: const Duration(seconds: 2), location: "location", distance: "50", stroke: "stroke"),
    ];

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.y(),
        interval: 1,
        axisLine: AxisLine(color: Colors.grey[200]),
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        minimum: DateTime(2016, 1),
        maximum: DateTime(2023, 1),
        intervalType: DateTimeIntervalType.years,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        maximum: 10,
        minimum: 0,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: <ChartSeries<EventTimeData, DateTime>>[
        LineSeries<EventTimeData, DateTime>(
          dataSource: eventTimeData,
          color: Colors.grey[200],
          xValueMapper: (EventTimeData event, _) => event.date,
          yValueMapper: (EventTimeData event, _) => event.time.inSeconds,
          animationDuration: 0,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
          ),
        ),
      ],
    );
  }
}

class EventTimeData {
  const EventTimeData({
    required this.date,
    required this.time,
    required this.location,
    required this.distance,
    required this.stroke,
  });

  final DateTime date;
  final Duration time;
  final String location;
  final String distance;
  final String stroke;
}
