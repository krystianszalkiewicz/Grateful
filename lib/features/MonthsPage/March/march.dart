import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/repositories/march_repositories.dart';

import '../January/january.dart';
import 'cubit/march_cubit.dart';

class March extends StatelessWidget {
  const March({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MarchGratefulPage(),
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            'March',
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

class MarchGratefulPage extends StatelessWidget {
  MarchGratefulPage({Key? key}) : super(key: key);

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
        create: (context) => MarchCubit(
          MarchRepositories(),
        ),
        child: BlocBuilder<MarchCubit, MarchState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<MarchCubit>().add(
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
          create: (context) => MarchCubit(
                MarchRepositories(),
              )..start(),
          child: BlocBuilder<MarchCubit, MarchState>(
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
                    BlocBuilder<MarchCubit, MarchState>(
                      builder: (context, state) {
                        return Dismissible(
                          key: ValueKey(itemModel.id),
                          onDismissed: (_) {
                            context.read<MarchCubit>().delete(
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
