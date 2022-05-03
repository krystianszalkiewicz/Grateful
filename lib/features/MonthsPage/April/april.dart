import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/repositories/april_repositories.dart';

import '../January/january.dart';
import 'cubit/april_cubit.dart';
import 'cubit/april_state.dart';
import 'package:rive/rive.dart';

class April extends StatelessWidget {
  const April({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AprilGratefulPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            'April',
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

class AprilGratefulPage extends StatelessWidget {
  AprilGratefulPage({Key? key}) : super(key: key);

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
        create: (context) => AprilCubit(
          AprilRepositories(),
        ),
        child: BlocBuilder<AprilCubit, AprilState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<AprilCubit>().add(
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
        create: (context) => AprilCubit(
          AprilRepositories(),
        )..start(),
        child: BlocBuilder<AprilCubit, AprilState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Text('Something went wrong');
            }
            if (state.isLoadiing) {
              return const RiveAnimation.network(
                'https://rive.app/community/944-1847-lodinganimate/',
              );
            }
            final itemModels = state.documents;
            return ListView(
              children: [
                for (final itemModel in itemModels) ...[
                  BlocBuilder<AprilCubit, AprilState>(
                    builder: (context, state) {
                      return Dismissible(
                        key: ValueKey(itemModel.id),
                        onDismissed: (_) {
                          context.read<AprilCubit>().delete(
                                document: itemModel,
                                id: itemModel.id,
                              );
                        },
                        child: NameWidget(
                          itemModel.name,
                        ),
                      );
                    },
                  ),
                ],
                TextField(controller: controller),
              ],
            );
          },
        ),
      ),
    );
  }
}
