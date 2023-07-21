import 'package:flutter/material.dart';

import 'package:ccswims_repository/ccswims_repository.dart';

import 'app/app.dart';

void main() {
  final ccswimsRepository = CCSwimsRepository();

  runApp(App(
    ccswimsRepository: ccswimsRepository,
  ));
}
