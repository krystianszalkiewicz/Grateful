import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:thankfulness/features/Auth/pages/user_profile.dart';
import 'package:thankfulness/models/Widgets/name_widget_yellow.dart';
import '../MonthsPage/April/april.dart';
import '../MonthsPage/August/august.dart';
import '../MonthsPage/December/december.dart';
import '../MonthsPage/February/february.dart';
import '../MonthsPage/January/january.dart';
import '../MonthsPage/July/july.dart';
import '../MonthsPage/June/june.dart';
import '../MonthsPage/March/march.dart';
import '../MonthsPage/May/may.dart';
import '../MonthsPage/November/november.dart';
import '../MonthsPage/October/october.dart';
import '../MonthsPage/September/september.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserProfile(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person,
              ),
              color: const Color.fromARGB(255, 0, 0, 0),
              iconSize: 35,
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          title: Center(
            child: Text(
              'Be grateful everyday',
              style: GoogleFonts.pacifico(
                color: const Color.fromARGB(255, 23, 213, 169),
                fontSize: 26,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 216, 228, 237),
        drawer: Drawer(
          child: ListView(
            children: const [
              January(),
              February(),
              March(),
              April(),
              May(),
              June(),
              July(),
              August(),
              September(),
              October(),
              November(),
              December(),
            ],
          ),
        ),
        body: Column(
          children: const [
            NameWidget('Monthly grateful counter'),
            SizedBox(
              height: 20,
            ),
            NameYellowWidget('60'),
            Expanded(
              child: RiveAnimation.asset(
                'assets/a.riv',
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
