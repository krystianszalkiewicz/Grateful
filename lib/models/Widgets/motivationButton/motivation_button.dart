import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            background = !background;
            motivation = !motivation;
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: background
              ? Colors.yellow
              : const Color.fromARGB(255, 23, 213, 169),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Text(
          motivation ? 'Motywacyjny cytat od Misia' : 'coś tam',
          style: GoogleFonts.pacifico(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
