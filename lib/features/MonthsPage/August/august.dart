import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class August extends StatelessWidget {
  const August({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'August',
          style: GoogleFonts.mukta(
            fontSize: 30,
          ),
        ),
      ),
      color: Colors.amberAccent,
    );
  }
}
