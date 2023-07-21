import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ccswims_repository/ccswims_repository.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required CCSwimsRepository ccswimsRepository,
  }) : _ccswimsRepository = ccswimsRepository,
      super(key: key);
  
  final CCSwimsRepository _ccswimsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _ccswimsRepository)
      ],
      child: const AppView(),
    );
  }
}
