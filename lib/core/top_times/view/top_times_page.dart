import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswim_viz/shared/scaffold/ccswim_scaffold.dart';

import 'top_times_view.dart';

class TopTimesPage extends StatelessWidget {
  const TopTimesPage({super.key});

  static const String name = 'top_times';

  @override
  Widget build(BuildContext context) {
    return CCSwimScaffold(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MultiBlocProvider(
            providers: const [],
            child: const TopTimesView(),
          ),
        ),
      ),
    );
  }
}
