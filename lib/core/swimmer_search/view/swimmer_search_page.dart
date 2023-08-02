import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';
import 'package:ccswims_repository/ccswims_repository.dart';

import 'swimmer_search_view.dart';

class SwimmerSearchPage extends StatelessWidget {
  const SwimmerSearchPage({super.key});

  static const String name = 'swimmer_search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
        centerTitle: false,
        backgroundColor: Colors.grey[100],
      ),
      body: SingleChildScrollView(
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
            ],
              child: const SwimmerSearchView(),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/logo/logo_blue.png', fit: BoxFit.contain, height: 40),
        const SizedBox(width: 12.0),
        Text(
          "CCSwimViz",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: neutral[3],
            fontWeight: FontWeight.normal,
          )
        ),
      ],
    );
  }
}
