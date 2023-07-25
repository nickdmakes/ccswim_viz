import 'package:ccswim_viz/core/swimmer_search/bloc/swimmer_search/swimmer_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/InteractiveDataTable/interactive_data_table.dart';

class SwimmerSearchView extends StatelessWidget {
  const SwimmerSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<SwimmerSearchBloc>().add(const SearchSwimmer(fullnameSearch: "Nicholas Matthews", clubSearch: "ISUSC"));
          },
          child: const Text("Get Swimmers"),
        ),
        BlocBuilder<SwimmerSearchBloc, SwimmerSearchState>(
          builder: (context, state) {
            if(state is SwimmerSearchNotStarted) {
              return const Text("Swimmers not searched yet");
            } else if(state is SwimmerSearchLoading) {
              return const CircularProgressIndicator();
            } else if(state is SwimmerSearchSuccessful) {
              return InteractiveDataTable(tableData: state.swimmers);
            } else {
              return const Center(
                child: Text("Failure"),
              );
            }
          }
        ),
      ],
    );
  }
}
