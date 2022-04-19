import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/auth_service.dart';
import 'package:notesapp/views/register_view.dart';
import 'package:notesapp/views/verify_email_view.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';
import 'dart:developer' as devtools show log;
import 'package:notesapp/views/notes_view.dart';

// ressho coders
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget myMargin(context) {
    //   return Container(
    //     margin: const EdgeInsets.all(10),
    //   );
    // }

    return FutureBuilder(
      // to initilize the firebase app

      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:

            // to get the current user
            final user = AuthService.firebase().currentUser;
            // final emailVerified = user?.emailVerified ?? false;
            if (user != null) {
              if (user.isEmailVerified) {
                devtools.log("Email id verified");
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const NotesView();
          default:
            return const Text("Loading...");
        }
      },
    );
  }
}
