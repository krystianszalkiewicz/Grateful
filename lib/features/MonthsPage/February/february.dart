import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class February extends StatelessWidget {
  const February({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'February',
          style: GoogleFonts.mukta(
            fontSize: 30,
          ),
        ),
      ),
      color: Colors.amberAccent,
    );
  }
}
