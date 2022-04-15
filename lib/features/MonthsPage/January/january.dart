import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class January extends StatelessWidget {
  const January({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'January',
        style: GoogleFonts.poppins(),
      ),
      color: Colors.amberAccent,
    );
  }
}
