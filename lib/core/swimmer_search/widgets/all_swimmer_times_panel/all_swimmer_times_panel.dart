import 'package:ccswim_viz/shared/dashboard_table/dashboard_table.dart';
import 'package:ccswims_repository/ccswims_repository.dart';
import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'util/times_data_manager.dart';
import 'package:ccswim_viz/core/swimmer_search/bloc/all_swimmer_times/all_swimmer_times_bloc.dart';

class AllSwimmerTimesPanel extends StatelessWidget {
  const AllSwimmerTimesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //_TimesFilters(),
        Expanded(
          child: _TimesTable(),
        ),
      ],
    );
  }
}

class _TimesFilters extends StatelessWidget {
  const _TimesFilters();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 40, width: 100, color: neutral[3], child: const Center(child: Text("Filter"))),
        Container(height: 40, width: 100, color: neutral[3], child: const Center(child: Text("Filter"))),
        Container(height: 40, width: 100, color: neutral[3], child: const Center(child: Text("Filter"))),
      ],
    );
  }
}

class _TimesTable extends StatelessWidget {
  const _TimesTable();

  @override
  Widget build(BuildContext context) {
    final List<String> columnNames = ["Event", "Time", "Date", "Name", "Location"];
    final List<String> keyNames = ["distance_stroke", "time", "date", "name", "location"];

    return BlocBuilder<AllSwimmerTimesBloc, AllSwimmerTimesState>(
      builder: (context, state) {
        if(state is AllSwimmerTimesFetchNotStarted) {
          return _EmptyTimesTable(columnNames: columnNames, keyNames: keyNames);
        } else if(state is AllSwimmerTimesFetchLoading) {
          return _LoadingTimesTable(columnNames: columnNames, keyNames: keyNames);
        } else if(state is AllSwimmerTimesFetchSuccessful) {
          return _FilteredTimesTable(columnNames: columnNames, keyNames: keyNames, times: state.times, swimmerName: state.fullname, clubName: state.club);
        } else {
          return const _TimesTableError();
        }
      }
    );
  }
}

class _EmptyTimesTable extends StatelessWidget {
  const _EmptyTimesTable({required this.columnNames, required this.keyNames});

  final List<String> columnNames;
  final List<String> keyNames;

  @override
  Widget build(BuildContext context) {
    return DashboardTable(tableData: const [], columnNames: columnNames, columnKeys: keyNames);
  }
}

class _LoadingTimesTable extends StatelessWidget {
  const _LoadingTimesTable({
    required this.columnNames,
    required this.keyNames,
  });

  final List<String> columnNames;
  final List<String> keyNames;

  @override
  Widget build(BuildContext context) {
    return DashboardTable(
      tableData: const [],
      columnNames: columnNames,
      columnKeys: keyNames,
      headerTitle: Text(
        "Loading times...",
        style: TextStyle(color: neutral[3]),
      ),
      isLoading: true,
    );
  }
}

class _TimesTableError extends StatelessWidget {
  const _TimesTableError();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _FilteredTimesTable extends StatelessWidget {
  const _FilteredTimesTable({
    required this.columnNames,
    required this.keyNames,
    required this.times,
    required this.swimmerName,
    required this.clubName,
  });

  final List<String> columnNames;
  final List<String> keyNames;
  final List<dynamic> times;
  final String swimmerName;
  final String clubName;

  @override
  Widget build(BuildContext context) {

    final timesManager = TimesDataManager(times: times.cast<Map<String, dynamic>>());
    timesManager.combineDistanceAndStroke();

    return DashboardTable(
      tableData: timesManager.getTimes(),
      columnNames: columnNames,
      columnKeys: keyNames,
      headerTitle: Text(
        "$swimmerName from $clubName",
        style: TextStyle(color: neutral[3]),
      ),
      onClearPressed: () => context.read<AllSwimmerTimesBloc>().add(ResetAllSwimmerTimes()),
    );
  }
}
