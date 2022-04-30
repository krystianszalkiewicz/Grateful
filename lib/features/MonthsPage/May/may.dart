import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/repositories/may_repositories.dart';

import '../../../models/Widgets/name_widget.dart';
import 'cubit/may_cubit.dart';

class May extends StatelessWidget {
  const May({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'May',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      color: const Color.fromARGB(255, 23, 213, 169),
    );
  }
}
class MayGratefulPage extends StatelessWidget {
  MayGratefulPage({Key? key}) : super(key: key);

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
        create: (context) => MayCubit(
          MayRepositories(),
        ),
        child: BlocBuilder<MayCubit, MayState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<MayCubit>().add(
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
          create: (context) => MayCubit(
                MayRepositories(),
              )..start(),
          child: BlocBuilder<MayCubit, MayState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return const Text('Something went wrong');
              }
              if (state.isLoadiing) {
                return const Center(child: CircularProgressIndicator());
              }
              final itemModels = state.documents;
              return ListView(
                children: [
                  for (final itemModel in itemModels) ...[
                    BlocBuilder<MayCubit, MayState>(
                      builder: (context, state) {
                        return Dismissible(
                          key: ValueKey(itemModel.id),
                          onDismissed: (_) {
                            context.read<MayCubit>().delete(
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
          )),
    );
  }
}
