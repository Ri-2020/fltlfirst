import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget myMargin(context) {
      return Container(
        margin: const EdgeInsets.all(10),
      );
    }

    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        // **futurbuilder** widget is used if we want to build the widget after task completion as in this first the firebase app is initilized and only then the coloumn get rendered on the screen
        child: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  // this widget will be a future
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "email@example.com",
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _password,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "p@5SWord",
                      ),
                    ),
                    myMargin(context),
                    TextButton(
                      onPressed: () async {
                        final String email = _email.text;
                        final String password = _password.text;
                        // firebase error handling
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "weak-password") {
                            print("Weak Password");
                          } else if (e.code == "email-already-in-use") {
                            print("Email Already in Use");
                          } else if (e.code == "invalid-email") {
                            print("Invalid email entered");
                          } else {
                            print("Someting Bad Happen");
                          }
                        }
                        // this function is to create an instance of a new user in the firebase
                        // print(userCredetials);
                      },
                      child: const Text("Register"),
                    ),
                  ],
                );
              default:
                return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
