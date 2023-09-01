import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/time_filters_cubit.dart';

class AllTimesFilters extends StatelessWidget {
  const AllTimesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _BestTimesOnlyButton(),
        const SizedBox(width: 4.0),
        const _SeasonDropdownSelect(),
        Container(height: 35, width: 100, color: neutral[3], child: const Center(child: Text("Filter"))),
        Container(height: 35, width: 100, color: neutral[3], child: const Center(child: Text("Filter"))),
      ],
    );
  }
}

class _BestTimesOnlyButton extends StatelessWidget {
  const _BestTimesOnlyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // return an outlined button that highlights when toggled and changes the state of the bestTimes in the TimeFiltersCubit
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      buildWhen: (previous, current) => previous.bestTimes != current.bestTimes,
      builder: (context, state) {
        return SizedBox(
          height: 35,
          child: OutlinedButton(
            onPressed: () {
              context.read<TimeFiltersCubit>().bestTimesToggled(!state.bestTimes);
            },
            style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: state.bestTimes ? neutral[0] : neutral[4],
              backgroundColor: state.bestTimes ? success[4] : neutral[0],
            ),
            child: const Text("Best Times"),
          ),
        );
      }
    );
  }
}

class _SeasonDropdownSelect extends StatelessWidget {
  const _SeasonDropdownSelect({super.key});

  @override
  Widget build(BuildContext context) {
    // return a dropdown select that changes the state of the season in the TimeFiltersCubit
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      buildWhen: (previous, current) => previous.season != current.season,
      builder: (context, state) {
        return SizedBox(
          height: 35,
          width: 120,
          child: DropdownButtonFormField<String>(
            value: state.season,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
            onChanged: (value) {
              context.read<TimeFiltersCubit>().seasonChanged(value!);
            },
            items: const [
              DropdownMenuItem(
                value: "All",
                child: Text("All"),
              ),
              DropdownMenuItem(
                value: "2020-2021",
                child: Text("2020-2021"),
              ),
              DropdownMenuItem(
                value: "2019-2020",
                child: Text("2019-2020"),
              ),
              DropdownMenuItem(
                value: "2018-2019",
                child: Text("2018-2019"),
              ),
              DropdownMenuItem(
                value: "2017-2018",
                child: Text("2017-2018"),
              ),
              DropdownMenuItem(
                value: "2016-2017",
                child: Text("2016-2017"),
              ),
            ],
          ),
        );
      }
    );
  }
}

