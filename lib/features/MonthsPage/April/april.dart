import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class April extends StatelessWidget {
  const April({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'April',
          style: GoogleFonts.mukta(
            fontSize: 30,
          ),
        ),
      ),
      color: Colors.amberAccent,
    );
  }
}
