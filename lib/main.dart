import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/views/register_view.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';

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
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget myMargin(context) {
      return Container(
        margin: const EdgeInsets.all(10),
      );
    }

    return FutureBuilder(
      // to initilize the firebase app

      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:

            // to get the current user
            // final user = FirebaseAuth.instance.currentUser;
            // final emailVerified = user?.emailVerified ?? false;
            // print(user);
            // if (emailVerified) {
            //   return const Text("Done");
            // } else {
            //   return const VerifyEmailView();
            // }

            return const LoginView();

          default:
            return const Text("Loading...");
        }
      },
    );
  }
}
