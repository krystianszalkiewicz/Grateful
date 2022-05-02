import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:thankfulness/features/HomePage%20/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: SignInScreen(
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to Grateful! Please sign in to continue.'
                        : 'Welcome to Grateful! Please create an account to continue',
                  ),
                );
              },
              footerBuilder: (context, _) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'By signing in, you agree to our terms and conditions.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
              headerBuilder: (context, constraints, _) {
                return const Padding(
                  padding: EdgeInsets.all(0.1),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image(
                      image: AssetImage('images/gratefeel-2.gif'),
                      fit: BoxFit.scaleDown,
                      width: 150,
                    ),
                  ),
                );
              },
              providerConfigs: const [
                EmailProviderConfiguration(),
              ],
            ),
          );
        }

        return  const HomePage();
      },
    );
  }
}
