import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cubit/time_filters_cubit.dart';

class AllTimesFilters extends StatelessWidget {
  const AllTimesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _BestTimesOnlyButton(),
        SizedBox(width: 4.0),
        _SeasonDropdownSelect(),
        SizedBox(width: 4.0),
        _StrokeDropdownSelect(),
        SizedBox(width: 4.0),
        _DistanceDropdownSelect(),
      ],
    );
  }
}

class _BestTimesOnlyButton extends StatelessWidget {
  const _BestTimesOnlyButton();

  @override
  Widget build(BuildContext context) {
    // return an outlined button that highlights when toggled and changes the state of the bestTimes in the TimeFiltersCubit
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      buildWhen: (previous, current) => previous.bestTimes != current.bestTimes,
      builder: (context, state) {
        return SizedBox(
          height: 30,
          child: OutlinedButton(
            onPressed: () {
              context.read<TimeFiltersCubit>().bestTimesToggled(!state.bestTimes);
            },
            style: OutlinedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: state.bestTimes ? neutral[0] : neutral[4],
              backgroundColor: state.bestTimes ? primary[4] : neutral[0],
            ),
            child: const Text("Bests", style: TextStyle(fontSize: 10.0)),
          ),
        );
      }
    );
  }
}

class _SeasonDropdownSelect extends StatelessWidget {
  const _SeasonDropdownSelect();

  @override
  Widget build(BuildContext context) {
    // return a dropdown select that changes the state of the season in the TimeFiltersCubit
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      buildWhen: (previous, current) => previous.season != current.season,
      builder: (context, state) {
        return _FilterDropdownSelect(
          options: const ["All", "22 - 23", "21 - 22", "20 - 21", "19 - 20", "18 - 19", "17 - 18"],
          selectedOption: state.season,
          onChanged: (season) {
            context.read<TimeFiltersCubit>().seasonChanged(season!);
          },
          prefixIcon: Icon(Icons.calendar_month_rounded, color: state.season != "All" ? neutral[0] : primary[4], size: 18.0),
        );
      }
    );
  }
}

class _StrokeDropdownSelect extends StatelessWidget {
  const _StrokeDropdownSelect();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
      buildWhen: (previous, current) => previous.stroke != current.stroke,
      builder: (context, state) {
        return _FilterDropdownSelect(
          options: const ["All", "Free", "Back", "Breast", "Fly", "IM"],
          selectedOption: state.stroke,
          onChanged: (stroke) {
            context.read<TimeFiltersCubit>().strokeChanged(stroke!);
          },
          prefixIcon: FaIcon(FontAwesomeIcons.personSwimming, color: state.stroke != "All" ? neutral[0] : primary[4], size: 18.0),
        );
      }
    );
  }
}

class _DistanceDropdownSelect extends StatelessWidget {
  const _DistanceDropdownSelect();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeFiltersCubit, TimeFiltersState>(
        buildWhen: (previous, current) => previous.stroke != current.stroke || previous.distance != current.distance,
        builder: (context, state) {
          final distances = _getDistancesFromStroke(state.stroke);
          final distanceInStroke = distances.contains(state.distance);

          if(!distanceInStroke) {
            context.read<TimeFiltersCubit>().distanceChanged("All");
          }

          return _FilterDropdownSelect(
            options: distances,
            selectedOption: distanceInStroke ? state.distance : "All",
            onChanged: (distance) {
              context.read<TimeFiltersCubit>().distanceChanged(distance!);
            },
            prefixIcon: FaIcon(FontAwesomeIcons.rulerVertical, color: state.distance != "All" ? neutral[0] : primary[4], size: 18.0)
          );
        }
    );
  }

  List<String> _getDistancesFromStroke(String stroke) {
    switch (stroke) {
      case "Free":
        return ["All", "50", "100", "200", "400", "500", "800", "1000"];
      case "Back":
        return ["All", "50", "100", "200"];
      case "Breast":
        return ["All", "50", "100", "200"];
      case "Fly":
        return ["All", "50", "100", "200"];
      case "IM":
        return ["All", "100", "200", "400"];
      default:
        return ["All"];
    }
  }
}

class _FilterDropdownSelect extends StatelessWidget {
  const _FilterDropdownSelect({
    this.options,
    this.selectedOption,
    this.onChanged,
    this.prefixIcon,
  });

  final List<String>? options;
  final String? selectedOption;
  final Function(String?)? onChanged;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: selectedOption! != "All" ? primary[4] : neutral[0],
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
            border: Border.all(width: 0.5, color: neutral[3]),
          ),
          child: Center(child: prefixIcon),
        ),
        Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
            color: neutral[0],
            borderRadius: const BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
            border: Border.all(width: 0.5, color: neutral[3]),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedOption,
              padding: const EdgeInsets.only(left: 8),
              alignment: AlignmentDirectional.center,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down_rounded, color: neutral[4]),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: neutral[4], fontSize: 10.0),
              onChanged: onChanged,
              items: options!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
