import 'package:flutter/material.dart';

class InteractiveDataTable extends StatefulWidget {
  const InteractiveDataTable({required this.tableData, super.key});

  final List<dynamic> tableData;

  @override
  State<InteractiveDataTable> createState() => _InteractiveDataTableState();
}

class _InteractiveDataTableState extends State<InteractiveDataTable> {
  int _selectedRowIndex = -1;

  @override
  Widget build(BuildContext context) {
    // Get keys from tableData by mapping the first row of the tableData into a list of DataColumns
    List<DataColumn> columns = widget.tableData[0].keys.map<DataColumn>((key) => DataColumn(label: Text(key))).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        showCheckboxColumn: false,
        columns: columns,
        rows: List<DataRow>.generate(
          widget.tableData.length,
              (index) => DataRow(
            onSelectChanged: (_) {
              setState(() {
                _selectedRowIndex = index;
              });
              print('Fullname: ${widget.tableData[index]["fullname"]}, Club: ${widget.tableData[index]["club"]}');
            },
            color: MaterialStateColor.resolveWith((states) {
              if(_selectedRowIndex == index) {
                return Colors.green;
              }
              if (states.contains(MaterialState.hovered)) {
                return Colors.blue; // Change the color when hovering
              }
              return Colors.transparent; // Use the default color
            }),
            cells: <DataCell>[
              DataCell(Text(widget.tableData[index]["fullname"])),
              DataCell(Text(widget.tableData[index]["club"])),
            ],
          ),
        ),
      ),
    );
  }
}
