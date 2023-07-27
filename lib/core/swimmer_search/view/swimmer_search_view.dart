import 'package:flutter/material.dart';

import 'package:ccswim_viz/shared/dashboard_card/dashboard_card.dart';
import '../widgets/swimmer_lookup_panel/swimmer_lookup_panel.dart';
import '../widgets/all_swimmer_times_panel/all_swimmer_times_panel.dart';

class SwimmerSearchView extends StatelessWidget {
  const SwimmerSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DashboardCard(
            child: SwimmerLookupPanel(),
          ),
        ),
        Expanded(
          flex: 2,
          child: DashboardCard(
            child: AllSwimmerTimesPanel(),
          ),
        ),
      ],
    );
  }
}
