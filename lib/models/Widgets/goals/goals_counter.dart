import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:thankfulness/App/core/enums.dart';
import 'package:thankfulness/data/remote_data_sources/goals_remote_data_sources.dart';
import 'package:thankfulness/models/Widgets/goals/cubit/golas_counter_cubit.dart';
import 'package:thankfulness/repositories/goals_repositories.dart';

class GoalsCounter extends StatelessWidget {
  const GoalsCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoalsCounterCubit(GoalsRepositories(GoalsRemoteDataSource()))..start(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<GoalsCounterCubit, GoalsCounterState>(
          builder: (context, state) {
            if (state.status == Status.error) {
              final errrorMessage =
                  state.errorMessage ?? 'Wystąpił nieoczekiwany problem';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errrorMessage),
                  backgroundColor: Colors.amber,
                ),
              );
            }
            if (state.status == Status.loading) {
              return const RiveAnimation.network(
                'https://rive.app/community/944-1847-lodinganimate/',
              );
            }

            return Text(
              state.count.length.toString(),
              style: GoogleFonts.pacifico(
                color: Colors.white,
                fontSize: 23,
              ),
            );
          },
        ),
      ),
    );
  }
}
