import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Widgets/name_widget.dart';
import '../../../repositories/november_repositories.dart';
import 'cubit/november_cubit.dart';

class November extends StatelessWidget {
  const November({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NovemberGratefulPage(),
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            'November',
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

class NovemberGratefulPage extends StatelessWidget {
  NovemberGratefulPage({Key? key}) : super(key: key);

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
        create: (context) => NovemberCubit(
          NovemberRepositories(),
        ),
        child: BlocBuilder<NovemberCubit, NovemberState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<NovemberCubit>().add(
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
          create: (context) => NovemberCubit(
                NovemberRepositories(),
              )..start(),
          child: BlocBuilder<NovemberCubit, NovemberState>(
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
                    BlocBuilder<NovemberCubit, NovemberState>(
                      builder: (context, state) {
                        return Dismissible(
                          key: ValueKey(itemModel.id),
                          onDismissed: (_) {
                            context.read<NovemberCubit>().delete(
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
