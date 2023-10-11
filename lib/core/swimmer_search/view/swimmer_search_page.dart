import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';
import 'package:ccswims_repository/ccswims_repository.dart';
import 'package:ccswim_viz/shared/scaffold/ccswim_scaffold.dart';

import 'swimmer_search_view.dart';

class SwimmerSearchPage extends StatelessWidget {
  const SwimmerSearchPage({super.key});

  static const String name = 'swimmer_search';

  @override
  Widget build(BuildContext context) {
    return CCSwimScaffold(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SwimmerSearchBloc>(
                create: (_) => SwimmerSearchBloc(context.read<CCSwimsRepository>()),
              ),
              BlocProvider<AllSwimmerTimesBloc>(
                create: (_) => AllSwimmerTimesBloc(context.read<CCSwimsRepository>()),
              ),
              BlocProvider<SelectedTimeBloc>(
                create: (_) => SelectedTimeBloc(),
              )
            ],
              child: const SwimmerSearchView(),
          ),
        ),
      ),
    );
  }
}
