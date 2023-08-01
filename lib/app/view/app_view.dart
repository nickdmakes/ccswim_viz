import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:ccswim_viz/core/swimmer_search/swimmer_search.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CCSwimViz",
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: 'swimmer_search',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return MaxWidthBox(
            maxWidth: 2000,
            background: Container(color: neutral[0], child: Center(child: Text('Cool beanz'))),
            child: ResponsiveScaledBox(
              width: ResponsiveValue<double>(context, conditionalValues: [
                Condition.equals(name: MOBILE, value: 450),
                Condition.between(start: 450, end: 1100, value: 1100),
              ]).value,
              child: buildPage(settings.name ?? ''),
            ),
          );
        });
      },
    );
  }

  Widget buildPage(String name) {
    switch (name) {
      case 'swimmer_search':
        return const SwimmerSearchPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
