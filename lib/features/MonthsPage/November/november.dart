import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class November extends StatelessWidget {
  const November({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
