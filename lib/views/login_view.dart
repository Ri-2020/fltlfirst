import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        // **futurbuilder** widget is used if we want to build the widget after task completion as in this first the firebase app is initilized and only then the coloumn get rendered on the screen
        child: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
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
                        try {
                          final user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(user);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "user-not-found") {
                            print("User not Found");
                          } else if (e.code == "wrong-password") {
                            print("Wrong Password");
                          } else {
                            print("Someting Else happen");
                          }
                        }
                        // print("$email and $password");

                        // this function is to create an instance of a new user in the firebase
                        // print(userCredetials);
                      },
                      child: const Text("Login"),
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
