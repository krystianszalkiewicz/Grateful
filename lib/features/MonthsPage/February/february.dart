import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thankfulness/features/MonthsPage/January/january.dart';

import 'cubit/february_cubit.dart';

class February extends StatelessWidget {
  const February({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FebruaryGratefulPage(),
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            'February',
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

class FebruaryGratefulPage extends StatelessWidget {
  FebruaryGratefulPage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find resons to be grateful every day',
          style: GoogleFonts.pacifico(
            color: Colors.lightBlue,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => FebruaryCubit(),
        child: BlocBuilder<FebruaryCubit, FebruaryState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<FebruaryCubit>().add(
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
        create: (context) => FebruaryCubit()..start(),
        child: BlocBuilder<FebruaryCubit, FebruaryState>(
            builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Text('Something went wrong: ${state.errorMessage}');
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = state.documents;

          return ListView(
            children: [
              for (final document in documents) ...[
                BlocBuilder<FebruaryCubit, FebruaryState>(
                  builder: (context, state) {
                    return Dismissible(
                      key: ValueKey(document.id),
                      onDismissed: (_) {
                        context.read<FebruaryCubit>().delete(
                              document: document,
                              id: document.id,
                            );
                      },
                      child: NameWidget(
                        document['name'],
                      ),
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
