import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.yourProfile,
            style: GoogleFonts.pacifico(
              color: const Color.fromARGB(255, 23, 213, 169),
              fontSize: 35,
            ),
          ),
        ),
      ),
      providerConfigs: const [
        EmailProviderConfiguration(),
      ],
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        }),
      ],
      avatarSize: 200,
    );
  }
}
