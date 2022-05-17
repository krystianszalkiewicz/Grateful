import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:thankfulness/features/AppPages/Goals/goals.dart';
import 'package:thankfulness/features/Auth/pages/user_profile.dart';
import 'package:thankfulness/models/Widgets/goals/goals_counter.dart';
import 'package:thankfulness/models/Widgets/grateful/grateful_counter.dart';
import 'package:thankfulness/models/Widgets/motivationButton/motivation_button.dart';

import '../AppPages/Grateful/grateful.dart';

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
              color: Colors.black,
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
              'Wdzięczność',
              style: GoogleFonts.pacifico(
                color: const Color.fromARGB(255, 23, 213, 169),
                fontSize: 35,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 216, 228, 237),
        drawer: Drawer(
          child: ListView(
            children: const [
              Grateful(),
              Goals(),
            ],
          ),
        ),
        body: Column(
          children: const [
            SizedBox(
              height: 5,
            ),
            NameWidget('Twoja ilośc powodów do wdzięczności'),
            SizedBox(
              height: 5,
            ),
            GratefulCounter(),
            NameWidget('Twoja liczba celi do realizowania '),
            SizedBox(
              height: 5,
            ),
            GoalsCounter(),
            SizedBox(
              height: 5,
            ),
            MotivationButton(),
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
