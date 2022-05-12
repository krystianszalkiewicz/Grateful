import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/features/AppPages/Grateful/cubit/grateful_cubit.dart';

import 'package:thankfulness/repositories/grateful_repositories.dart';

import '../../../App/core/enums.dart';

class Grateful extends StatelessWidget {
  const Grateful({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GratefulPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Moje wdzięczności',
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

class GratefulPage extends StatelessWidget {
  GratefulPage({Key? key}) : super(key: key);

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
          'Moje powody do wdzięczności',
          style: GoogleFonts.pacifico(
            color: Colors.lightBlue,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => GratefulCubit(
          GratefulRepositories(),
        ),
        child: BlocBuilder<GratefulCubit, GratefulState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<GratefulCubit>().add(
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
        create: (context) => GratefulCubit(
          GratefulRepositories(),
        )..start(),
        child: BlocBuilder<GratefulCubit, GratefulState>(
          builder: (context, state) {
            if (state.status == Status.error) {
              final errorMessage =
                  state.errorMessage ?? 'Wystąpił nieoczekiwany błąd';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.amber,
              ));
            }

            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            final itemModels = state.documents;
            return ListView(
              children: [
                for (final itemModel in itemModels) ...[
                  BlocBuilder<GratefulCubit, GratefulState>(
                    builder: (context, state) {
                      return Dismissible(
                        key: ValueKey(itemModel.id),
                        onDismissed: (_) {
                          context.read<GratefulCubit>().delete(
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
                TextField(
                  controller: controller,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget(
    this.name, {
    Key? key,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 23, 213, 169),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(
        (name),
        style: GoogleFonts.pacifico(
          color: Colors.white,
          fontSize: 23,
        ),
      ),
    );
  }
}
