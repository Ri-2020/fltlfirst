import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

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
        margin: const EdgeInsets.all(20),
        child: Column(
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
                  final userCredentials =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notes/',
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    devtools.log("User not Found");
                  } else if (e.code == "wrong-password") {
                    devtools.log("Wrong Password");
                  } else {
                    devtools.log("Someting Else happen");
                  }
                }
                // devtools.log("$email and $password");

                // this function is to create an instance of a new user in the firebase
                // devtools.log(userCredetials);
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text("Not Registered Yet? Register Here"),
            )
          ],
        ),
      ),
    );
  }
}
