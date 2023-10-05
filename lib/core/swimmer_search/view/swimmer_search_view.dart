import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:ccswim_viz/shared/dashboard_card/dashboard_card.dart';
import '../widgets/swimmer_lookup_panel/swimmer_lookup_panel.dart';
import '../widgets/all_swimmer_times_panel/all_swimmer_times_panel.dart';
import '../widgets/swimmer_summary_panel/swimmer_summary_panel.dart';
import '../widgets/event_graph_panel/event_graph_panel.dart';

class SwimmerSearchView extends StatelessWidget {
  const SwimmerSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    if(ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)) {
      return const _MobileSwimmerSearchDashboard();
    } else {
      return const _DesktopSwimmerSearchDashboard();
    }
  }
}

class _MobileSwimmerSearchDashboard extends StatelessWidget {
  const _MobileSwimmerSearchDashboard();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DashboardCard(
          child: SwimmerLookupPanel(),
        ),
        DashboardCard(
          child: AllSwimmerTimesPanel(),
        ),
        DashboardCard(
          child: EventGraphPanel(),
        ),
        DashboardCard(
          child: SwimmerSummaryPanel(),
        ),
      ],
    );
  }
}

class _DesktopSwimmerSearchDashboard extends StatelessWidget {
  const _DesktopSwimmerSearchDashboard();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DashboardCard(
                child: SwimmerSummaryPanel(),
              ),
            ),
            Expanded(
              flex: 5,
              child: DashboardCard(
                child: EventGraphPanel(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
