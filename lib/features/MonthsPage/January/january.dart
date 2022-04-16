import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class January extends StatelessWidget {
  const January({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const JanuarygratefulPage(),
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            'January',
            style: GoogleFonts.pacifico(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        color: const Color.fromARGB(255, 23, 213, 169),
      ),
    );
  }
}

class JanuarygratefulPage extends StatelessWidget {
  const JanuarygratefulPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'find resons to be grateful every day',
          style: GoogleFonts.pacifico(
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
