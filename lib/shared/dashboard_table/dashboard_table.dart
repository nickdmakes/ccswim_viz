import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/dashboard_table_cubit.dart';

class DashboardTable extends StatelessWidget {
  DashboardTable({
    required this.tableData,
    required this.columnNames,
    required this.columnKeys,
    this.onRowSelected,
    this.dataRowHeight = 30,
    this.onClearPressed,
    this.headerTitle,
    this.isLoading = false,
    super.key,
  }) {
    assert(_validateColumnKeys(), "columnKeys must be a subset of tableData keys");
  }

  final List<dynamic> tableData;
  final List<String> columnNames;
  final List<String> columnKeys;
  final Function(int)? onRowSelected;
  final void Function()? onClearPressed;
  final Text? headerTitle;
  final double dataRowHeight;
  final bool isLoading;

  // Function to make sure all strings in columnKeys exist within tableData keys
  bool _validateColumnKeys() {
    if (tableData.isEmpty) {
      return true;
    }
    for (String key in columnKeys) {
      if (!tableData[0].keys.contains(key)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardTableCubit(),
      child: LayoutBuilder(
          builder: (context, constraints) {
            // reset the state
            context.read<DashboardTableCubit>().reset();

            // Update the tableData in the state
            context.read<DashboardTableCubit>().tableDataChanged(tableData);
            // Update the rowsPerPage in the state
            final double tableHeight = constraints.maxHeight - 100;
            final int rowsPerPage = (tableHeight / dataRowHeight).floor();
            context.read<DashboardTableCubit>().rowsPerPageChanged(rowsPerPage);

            final swimmerTable = _SwimmerDataTable(dataRowHeight: dataRowHeight, columnNames: columnNames, onRowSelected: onRowSelected, columnKeys: columnKeys);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PaginatedHeader(headerTitle: headerTitle),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double tableWidth = constraints.maxWidth;
                      if(isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if(tableData.isEmpty) {
                        return Center(child: Text("No data to display", style: TextStyle(color: neutral[3], fontSize: 14)));
                      } else {
                        return SingleChildScrollView(primary: false, physics: const ClampingScrollPhysics(), scrollDirection: Axis.vertical, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: ConstrainedBox(constraints: BoxConstraints(minWidth: tableWidth), child: swimmerTable)));
                      }
                    },
                  ),
                ),
                Builder(
                  builder: (context) {
                    if(tableData.isEmpty) {
                      return const _TableFooter();
                    } else {
                      return _TableFooter(onClearPressed: onClearPressed);
                    }
                  }
                ),
              ],
            );
          }
      ),
    );
  }
}

class _PaginatedHeader extends StatelessWidget {
  const _PaginatedHeader({this.headerTitle});

  final Text? headerTitle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTableCubit, DashboardTableState>(
      buildWhen: (previous, current) => previous.page != current.page,
      builder: (context, state) {
        // Get thee max number of pages
        final int maxPages = context.read<DashboardTableCubit>().maxPages;
        return Container(
          height: 30,
          decoration: BoxDecoration(
            color: neutral[2],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: headerTitle ?? Container(),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => state.page == 0 ? null : context.read<DashboardTableCubit>().pageChanged(state.page - 1),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.keyboard_arrow_left_rounded),
                splashRadius: 12,
                color: state.page == 0 ? neutral[3] : neutral[4],
              ),
              Text("${state.page} of $maxPages", style: TextStyle(color: neutral[3])),
              IconButton(
                onPressed: () => state.page == maxPages ? null : context.read<DashboardTableCubit>().pageChanged(state.page + 1),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                splashRadius: 12,
                color: state.page == maxPages ? neutral[3] : neutral[4],
              ),
            ],
          ),
        );
      }
    );
  }
}

class _SwimmerDataTable extends StatelessWidget {
  const _SwimmerDataTable({
    required this.dataRowHeight,
    required this.columnNames,
    required this.columnKeys,
    this.onRowSelected,
  });

  final double dataRowHeight;
  final List<String> columnNames;
  final List<String> columnKeys;
  final Function(int)? onRowSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTableCubit, DashboardTableState>(
      builder: (context, state) {
        // Get the data for the current page
        final List<dynamic> pageTableData = context.read<DashboardTableCubit>().pageTableData;
        return DataTable(
          horizontalMargin: 8,
          headingRowColor: MaterialStateColor.resolveWith((states) => neutral[1]),
          headingRowHeight: dataRowHeight,
          showCheckboxColumn: false,
          columns: _getDataColumns(columnNames: columnNames),
          rows: List<DataRow>.generate(
            pageTableData.length,
                (index) {
              return DataRow(
                onSelectChanged: (_) {
                  context.read<DashboardTableCubit>().selectedIndexChanged(index + (state.page * state.rowsPerPage));
                  if (onRowSelected != null) {
                    onRowSelected!(index + (state.page * state.rowsPerPage));
                  }
                },
                color: MaterialStateColor.resolveWith((states) {
                  if (state.selectedIndex == index + (state.page * state.rowsPerPage)) {
                    return secondary[1];
                  } else if (states.contains(MaterialState.hovered)) {
                    return primary[2]; // Change the color when hovering
                  } else if (states.contains(MaterialState.pressed)) {
                    return primary[3]; // Change the color when pressed
                  }
                  return Colors.transparent; // Use the default color
                }),
                // If the tableData is empty, return an empty list of DataCells, otherwise return the data cells
                // equal to the number of rowsPerPage at the given page
                cells: pageTableData.isEmpty ? [] : _getDataCells(pageTableData: pageTableData, index: index, columnKeys: columnKeys),
              );
            },
          ),
        );
      },
    );
  }

  // Get keys from tableData by mapping the first row of the tableData into a list of DataColumns
  List<DataColumn> _getDataColumns({required List<String> columnNames}) {
    List<DataColumn> columns = columnNames
        .map<DataColumn>((key) => DataColumn(
        label: Text(
          key,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: neutral[4]),
        ))).toList();
    return columns;
  }

  // Get the data cells from the tableData at the given index
  List<DataCell> _getDataCells({required List<dynamic> pageTableData, required List<String> columnKeys, required int index}) {
    List<DataCell> cells = columnKeys
        .map<DataCell>((key) => DataCell(Text(pageTableData[index][key])))
        .toList();
    return cells;
  }
}

class _TableFooter extends StatelessWidget {
  const _TableFooter({
    this.onClearPressed,
  });

  final void Function()? onClearPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardTableCubit, DashboardTableState>(
      builder: (context, state) {
        return Container(
          height: 30,
          decoration: BoxDecoration(
            color: neutral[0],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: state.tableData.isEmpty ? Container() : Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${state.tableData.length} results",
                  style: TextStyle(color: neutral[2]),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  if (onClearPressed != null) {
                    onClearPressed!();
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: primary[3], textStyle: const TextStyle(fontSize: 14),
                ),
                child: const Text('Clear Table'),
              ),
            ],
          ),
        );
      }
    );
  }
}
