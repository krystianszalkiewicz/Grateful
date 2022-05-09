import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/repositories/goals_repositories.dart';

import '../../../models/Widgets/name/name_widget.dart';
import 'cubit/goals_cubit.dart';

class GoalsCounter extends StatelessWidget {
  const GoalsCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GoalsGratefulPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Goals',
            style: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        color: const Color.fromARGB(255, 23, 213, 169),
      ),
    );
  }
}

class GoalsGratefulPage extends StatelessWidget {
  GoalsGratefulPage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        title: Text(
          'Find resons to be grateful every day',
          style: GoogleFonts.pacifico(
            color: Colors.lightBlue,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => GoalsCubit(
          GoalsRepositories(),
        ),
        child: BlocBuilder<GoalsCubit, GoalsState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<GoalsCubit>().add(
                      name: controller.text,
                    );
                controller.clear();
              },
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 47, 184, 129),
              ),
            );
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => GoalsCubit(
          GoalsRepositories(),
        )..start(),
        child: BlocBuilder<GoalsCubit, GoalsState>(
            builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Text('Something went wrong: ${state.errorMessage}');
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final itemModels = state.documents;

          return ListView(
            children: [
              for (final itemModel in itemModels) ...[
                BlocBuilder<GoalsCubit, GoalsState>(
                  builder: (context, state) {
                    return Dismissible(
                      key: ValueKey(itemModel.id),
                      onDismissed: (_) {
                        context.read<GoalsCubit>().delete(
                              document: itemModel,
                              id: itemModel.id,
                            );
                      },
                      child: NameWidget(itemModel.name),
                    );
                  },
                ),
              ],
              TextField(controller: controller),
            ],
          );
        }),
      ),
    );
  }
}
