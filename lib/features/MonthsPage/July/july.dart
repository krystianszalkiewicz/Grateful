import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class July extends StatelessWidget {
  const July({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'July',
         style: GoogleFonts.mukta(
            fontSize: 30,
          ),
        ),
      ),
      color: Colors.amberAccent,
    );
  }
}
