import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
