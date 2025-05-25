import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignIN extends StatefulWidget {
  const GoogleSignIN({super.key});

  @override
  State<GoogleSignIN> createState() => _GoogleSignINState();
}

class _GoogleSignINState extends State<GoogleSignIN> {
  GoogleSignIn signIn = GoogleSignIn();
  void googleSignIn() async {
    try {
      var user = await signIn.signIn();
      print(user);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Sign in")),
      body: Center(
        child: TextButton(
          onPressed: () {
            googleSignIn();
          },
          child: Text("Google sign in"),
        ),
      ),
    );
  }
}
