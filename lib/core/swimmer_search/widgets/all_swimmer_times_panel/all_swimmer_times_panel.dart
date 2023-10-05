import 'package:ccswim_viz/core/swimmer_search/bloc/selected_time/selected_time_bloc.dart';
import 'package:ccswim_viz/shared/dashboard_table/dashboard_table.dart';
import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/times_data_manager.dart';
import 'cubit/time_filters_cubit.dart';
import 'widgets/all_times_filters.dart';
import 'package:ccswim_viz/core/swimmer_search/bloc/all_swimmer_times/all_swimmer_times_bloc.dart';

class AllSwimmerTimesPanel extends StatefulWidget {
  const AllSwimmerTimesPanel({super.key});

  @override
  State<AllSwimmerTimesPanel> createState() => _AllSwimmerTimesPanelState();
}

class _AllSwimmerTimesPanelState extends State<AllSwimmerTimesPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimeFiltersCubit(),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AllTimesFilters(),
          SizedBox(height: 4.0),
          Expanded(
            child: _TimesTable(),
          ),
        ],
      ),
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
        style: TextStyle(color: neutral[1]),
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
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      builder: (context, state) {
        // pass a copy of times into the data manager
        final timesManager = TimesDataManager(times: List<Map<String, dynamic>>.from(times));
        if(state.bestTimes) {
          timesManager.filterByBestTimes();
        }
        if(state.season != "All") {
          final seasons = state.season.split("-");
          final startYear = seasons[0].trim();
          final endYear = seasons[1].trim();
          timesManager.filterBySeason(startYear, endYear);
        }
        if(state.stroke != "All") {
          timesManager.filterByStroke(state.stroke);
        }
        if(state.distance != "All") {
          timesManager.filterByDistance(state.distance);
        }

        return DashboardTable(
          tableData: timesManager.getTimes(),
          columnNames: columnNames,
          columnKeys: keyNames,
          headerTitle: Text(
            "$swimmerName from $clubName",
            style: TextStyle(color: neutral[1],
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onRowSelected: (index) {
            context.read<SelectedTimeBloc>().add(SelectTimeClicked(
              distance: timesManager.getTimes()[index]["distance"],
              stroke: timesManager.getTimes()[index]["stroke"],
              time: timesManager.getTimes()[index]["time"],
            ));
          },
          onClearPressed: () => context.read<AllSwimmerTimesBloc>().add(ResetAllSwimmerTimes()),
        );
      }
    );
  }
}
