import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:translife_google_signin/googleSignIn/google_sign_in_screen.dart';
import 'package:translife_google_signin/requestOtp/mobile_sms.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleSignInScreen()),
                );
              },
              child: Text("Google sign In"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mobilesms()),
                );
              },
              child: Text("Login with Mobile"),
            ),
          ],
        ),
      ),
    );
  }
}
