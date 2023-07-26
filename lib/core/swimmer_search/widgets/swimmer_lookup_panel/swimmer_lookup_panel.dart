import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/swimmer_lookup_panel_cubit.dart';
import 'package:ccswim_viz/core/swimmer_search/bloc/swimmer_search/swimmer_search_bloc.dart';
import 'package:ccswim_viz/shared/dashboard_input_field/dashboard_input_field.dart';

class SwimmerLookupPanel extends StatelessWidget {
  const SwimmerLookupPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SwimmerLookupPanelCubit(
        swimmerSearchBloc: context.read<SwimmerSearchBloc>()
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SwimmerNameInput(),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: _ClubNameInput(),
              ),
            ],
          ),
          _SwimmerLookupBody(),
        ],
      ),
    );
  }
}

class _SwimmerNameInput extends StatelessWidget {
  const _SwimmerNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimmerLookupPanelCubit, SwimmerLookupPanelState>(
      buildWhen: (previous, current) => previous.swimmerName != current.swimmerName,
      builder: (context, state) {
        return DashboardInputField(
          onChanged: (name) {
            context.read<SwimmerLookupPanelCubit>().swimmerNameChanged(name);
          },
          onSubmitted: (_) {
            context.read<SwimmerLookupPanelCubit>().swimmerSearchSubmitted();
          },
          placeholder: "[Firstname] [Lastname]",
          errorText: state.swimmerName.invalid ? '' : null,
          keyboardType: TextInputType.name,
        );
      },
    );
  }
}

class _ClubNameInput extends StatelessWidget {
  const _ClubNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimmerLookupPanelCubit, SwimmerLookupPanelState>(
      buildWhen: (previous, current) => previous.clubName != current.clubName,
      builder: (context, state) {
        return DashboardInputField(
          onChanged: (name) {
            context.read<SwimmerLookupPanelCubit>().clubNameChanged(name);
          },
          onSubmitted: (_) {
            context.read<SwimmerLookupPanelCubit>().swimmerSearchSubmitted();
          },
          placeholder: "[Club]",
          errorText: state.clubName.invalid ? '' : null,
          keyboardType: TextInputType.name,
        );
      },
    );
  }
}

class _SwimmerLookupBody extends StatelessWidget {
  const _SwimmerLookupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimmerLookupPanelCubit, SwimmerLookupPanelState>(
      buildWhen: (previous, current) => previous.error != current.error,
      builder: (context, state) {
        if(state.error == SwimmerLookupSubmissionError.invalidSubmission) {
          return Expanded(
            child: Center(child: _errorText(
                "*Invalid Search*\n\nAt least one field must not be blank\n\n- Name must be in format [Firstname] [Lastname]\n- Club must be in format [Club]",
            )),
          );
        } else {
          return Expanded(child: Container(color: Colors.amber));
        }
      },
    );
  }

  Widget _errorText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: error[3],
      ),
    );
  }
}
