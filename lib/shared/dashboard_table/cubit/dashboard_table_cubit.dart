import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_table_state.dart';

class DashboardTableCubit extends Cubit<DashboardTableState> {
  DashboardTableCubit() : super(const DashboardTableState());

  void rowsPerPageChanged(int rowsPerPage) {
    emit(state.copyWith(rowsPerPage: rowsPerPage));
  }

  void pageChanged(int page) {
    emit(state.copyWith(page: page));
  }

  void selectedIndexChanged(int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex));
  }

  void tableDataChanged(List<dynamic> tableData) {
    emit(state.copyWith(tableData: tableData));
  }

  // Function to get the max number of pages
  int get maxPages {
    final int maxPages = (state.tableData.length / state.rowsPerPage).floor();
    return maxPages;
  }

  // Function to get the data for the current page
  List<dynamic> get pageTableData {
    final int startIndex = state.page * state.rowsPerPage;
    final int endIndex = min((state.page + 1) * state.rowsPerPage, state.tableData.length);
    return state.tableData.sublist(startIndex, endIndex);
  }
}
