part of 'dashboard_table_cubit.dart';

class DashboardTableState extends Equatable {
  const DashboardTableState({
    this.rowsPerPage = 0,
    this.page = 0,
    this.selectedIndex = -1,
    this.tableData = const [],
  });

  final int rowsPerPage;
  final int page;
  final int selectedIndex;
  final List<dynamic> tableData;

  @override
  List<Object> get props => [rowsPerPage, page, selectedIndex, tableData];

  DashboardTableState copyWith({
    int? rowsPerPage,
    int? page,
    int? selectedIndex,
    List<dynamic>? tableData,
  }) {
    return DashboardTableState(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      page: page ?? this.page,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tableData: tableData ?? this.tableData,
    );
  }
}
