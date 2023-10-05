import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';
import 'widgets/single_event_graph.dart';

class EventGraphPanel extends StatelessWidget {
  const EventGraphPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSwimmerTimesBloc, AllSwimmerTimesState>(
      builder: (context, state) {
        if(state is AllSwimmerTimesFetchSuccessful) {
          final lastTime = state.times.last;
          context.read<SelectedTimeBloc>().add(SelectTimeClicked(distance: lastTime["distance"], stroke: lastTime["stroke"], time: lastTime["time"]));
          return EventGraphPanelContent(child: SingleEventGraph(times: state.times));
        } else {
          return const EventGraphPanelContent(child: SingleEventGraphEmpty());
        }
      }
    );
  }
}

class EventGraphPanelContent extends StatelessWidget {
  const EventGraphPanelContent({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTimeBloc, SelectedTimeState>(
      builder: (context, state) {
        final String label = state is SelectedTimeSelected ? "${state.distance} ${state.stroke}" : "No Event Selected";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    "Event Graph",
                    style: TextStyle(
                      fontSize: 18,
                      color: neutral[2],
                    )
                ),
                const Spacer(),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: neutral[2],
                  ),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: child ?? const Placeholder(),
              ),
            ),
          ],
        );
      },
    );
  }
}
