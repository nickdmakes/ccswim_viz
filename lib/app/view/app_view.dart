import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const SwimmerSearchPage(),
    );
  }
}
