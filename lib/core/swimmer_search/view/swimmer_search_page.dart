import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';
import 'package:ccswims_repository/ccswims_repository.dart';

import 'swimmer_search_view.dart';

class SwimmerSearchPage extends StatelessWidget {
  const SwimmerSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cool")
      ),
      body: BlocProvider(
        create: (_) => SwimmerSearchBloc(context.read<CCSwimsRepository>()),
          child: const SwimmerSearchView(),
      ),
    );
  }
}
