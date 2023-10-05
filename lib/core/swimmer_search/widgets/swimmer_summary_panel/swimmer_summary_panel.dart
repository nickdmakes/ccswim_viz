import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/stroke_pie_chart.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';

class SwimmerSummaryPanel extends StatelessWidget {
  const SwimmerSummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Stroke Distribution",
              style: TextStyle(
                fontSize: 18,
                color: neutral[2],
              )
            ),
            const Spacer(),
            const SelectedSwimmerLabel(),
          ],
        ),
        const Divider(),
        const Expanded(
          child: StrokePieChart(),
        ),
      ],
    );
  }
}

class SelectedSwimmerLabel extends StatelessWidget {
  const SelectedSwimmerLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSwimmerTimesBloc, AllSwimmerTimesState>(
      builder: (context, state) {
        if(state is AllSwimmerTimesFetchSuccessful) {
          final fullname = state.fullname;
          final club = state.club;
          return Text(
            "$fullname ($club)",
            style: TextStyle(
              fontSize: 12,
              color: neutral[2],
            ),
          );
        } else {
          return Text(
            "No Swimmer Selected",
            style: TextStyle(
              fontSize: 12,
              color: neutral[2],
            ),
          );
        }
      }
    );
  }
}
