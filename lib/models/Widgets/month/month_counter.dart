import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:thankfulness/models/Widgets/month/cubit/month_cubit.dart';
import 'package:thankfulness/repositories/april_repositories.dart';

class MonthCounter extends StatelessWidget {
  const MonthCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MonthCubit(AprilRepositories())..start(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<MonthCubit, MonthState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Text('Something went wrong');
            }
            if (state.isLoadiing) {
              return const RiveAnimation.network(
                'https://rive.app/community/944-1847-lodinganimate/',
              );
            }

            return Text(
              context.read<MonthCubit>().getCount().toString(),
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
