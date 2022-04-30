import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/features/MonthsPage/January/cubit/january_cubit.dart';
import 'package:thankfulness/repositories/item_repositories.dart';

class January extends StatelessWidget {
  const January({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => JanuarygratefulPage(),
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            'January',
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

class JanuarygratefulPage extends StatelessWidget {
  JanuarygratefulPage({Key? key}) : super(key: key);

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
        create: (context) => JanuaryCubit(
          JanuaryRepositories(),
        ),
        child: BlocBuilder<JanuaryCubit, JanuaryState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<JanuaryCubit>().add(
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
        create: (context) => JanuaryCubit(
          JanuaryRepositories(),
        )..start(),
        child: BlocBuilder<JanuaryCubit, JanuaryState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Text('Something went wrong : ${state.errorMessage}');
            }

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final itemModels = state.documents;
            return ListView(
              children: [
                for (final itemModel in itemModels) ...[
                  BlocBuilder<JanuaryCubit, JanuaryState>(
                    builder: (context, state) {
                      return Dismissible(
                        key: ValueKey(itemModel.id),
                        onDismissed: (_) {
                          context.read<JanuaryCubit>().delete(
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
