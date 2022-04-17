import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/views/register_view.dart';
import 'package:notesapp/views/verify_email_view.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';
import 'dart:developer' as devtools show log;

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
      '/notes/': (context) => const NotesView(),
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

      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:

            // to get the current user
            final user = FirebaseAuth.instance.currentUser;
            // final emailVerified = user?.emailVerified ?? false;
            if (user != null) {
              if (user.emailVerified) {
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

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          //popup menu button in appbar
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shoudLogout = await showLogOutDialog(context);
                  if (shoudLogout) {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                      (_) => false,
                    );
                  } else {}
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  child: Text("Log out"),
                  value: MenuAction.logout,
                )
              ];
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: const Text("This is main UI of the whole app."),
      ),
    );
  }
}

// Alert Dialog box
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign out"),
        content: const Text("Are you sure to want to signout"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("LogOut"),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
