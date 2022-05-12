import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:thankfulness/models/Widgets/motivationButton/cubit/motivationbutton_cubit.dart';
import 'package:thankfulness/repositories/motivation_repositories.dart';

class MotivationButton extends StatefulWidget {
  const MotivationButton({
    Key? key,
  }) : super(key: key);

  @override
  State<MotivationButton> createState() => _MotivationButtonState();
}

class _MotivationButtonState extends State<MotivationButton> {
  bool background = false;
  bool motivation = false;
  bool colorStyle = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            background = !background;
            motivation = !motivation;
            colorStyle = !colorStyle;
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: background
              ? const Color.fromARGB(255, 23, 213, 169)
              : Colors.yellow,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: BlocProvider(
          create: (context) => MotivationbuttonCubit(
            MotivationRepositories(),
          )..start(),
          child: BlocBuilder<MotivationbuttonCubit, MotivationbuttonState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return Text('Something went wrong : ${state.errorMessage}');
              }

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return BlocProvider(
                create: (context) =>
                    MotivationbuttonCubit(MotivationRepositories()),
                child:
                    BlocBuilder<MotivationbuttonCubit, MotivationbuttonState>(
                  builder: (context, state) {
                    return Text(
                      motivation
                          ? 'Motywacyjny cytat od Misia'
                          : state.documents.toString(),
                      style: colorStyle
                          ? GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 23,
                            )
                          : GoogleFonts.pacifico(
                              color: const Color.fromARGB(255, 23, 213, 169),
                              fontSize: 23),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
