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
          style: GoogleFonts.mukta(
            fontSize: 30,
          ),
        ),
      ),
      color: Colors.amberAccent,
    );
  }
}
