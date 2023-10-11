import 'package:flutter/material.dart';
import 'package:ccswim_viz/theme.dart';

class CCSwimScaffold extends StatelessWidget {
  const CCSwimScaffold({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
        centerTitle: false,
        backgroundColor: Colors.grey[100],
      ),
      body: child,
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

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
