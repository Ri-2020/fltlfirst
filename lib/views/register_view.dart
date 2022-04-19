// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;

import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/auth_service.dart';
import 'package:notesapp/services/auth/auth_exception.dart';
import '../utilities/show_error_dialog.dart';

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
                // firebase error handling
                try {
                  await AuthService.firebase()
                      .createUser(email: email, password: password);
                  // final user = AuthService.firebase().currentUser;
                  await AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  showErrorDialog(
                    context,
                    "Weak password, try a harder password",
                  );
                } on EmailAlreadyInUseAuthException {
                  showErrorDialog(
                    context,
                    "Email already in use, login or use another email address",
                  );
                } on InvalidEmailAddressAuthException {
                  showErrorDialog(
                    context,
                    "Email is invalid, Please enter a valid email address",
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    "Authinticaton Error Occured",
                  );
                }
              },
              child: const Text("Register"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Already Have an account Login Here"),
            )
          ],
        ),
      ),
    );
  }
}
