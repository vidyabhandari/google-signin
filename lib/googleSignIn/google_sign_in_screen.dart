import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Initialize GoogleSignIn.
// If you need specific scopes beyond email, profile, and openid,
// you can specify them here, for example:
// final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'https://www.googleapis.com/auth/contacts.readonly']);
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email', // Basic email scope
    'profile',
    // Basic profile information (name, picture)
    // Add more scopes as needed for your application
    // e.g., 'https://www.googleapis.com/auth/calendar.readonly'
  ],
  clientId: '652169325897-t77c15smnpj0seh4idcpq8niks4tav9f.apps.googleusercontent.com',
);

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  // Holds the currently signed-in Google user account.
  GoogleSignInAccount? _currentUser;
  // Message to display for errors or status updates.
  String _message = '';

  @override
  void initState() {
    super.initState();
    // Listen for changes in the sign-in state.
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
        print(_currentUser);
        if (_currentUser != null) {
          _message =
              'Signed in as ${_currentUser!.displayName} (${_currentUser!.email})';
        } else {
          _message = 'Not signed in.';
        }
      });
    });
    // Attempt to sign in silently when the app starts.
    // This will check if a user is already signed in from a previous session.
    _googleSignIn.signInSilently();
  }

  // Handles the Google Sign-In process.
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // If signIn() completes successfully, onCurrentUserChanged listener will update _currentUser.
    } catch (error) {
      setState(() {
        _message = 'Error signing in: $error';
      });
      print('Error signing in: $error'); // Print to console for debugging
    }
  }

  // Handles the Google Sign-Out process.
  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      // If signOut() completes successfully, onCurrentUserChanged listener will update _currentUser.
    } catch (error) {
      setState(() {
        _message = 'Error signing out: $error';
      });
      print('Error signing out: $error'); // Print to console for debugging
    }
  }

  // Builds the main UI based on the sign-in state.
  Widget _buildBody() {
    if (_currentUser != null) {
      // User is signed in.
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
              _currentUser!.photoUrl ??
                  'https://placehold.co/100x100?text=No+Photo',
            ),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text('Welcome, ${_currentUser!.displayName ?? 'User'}!'),
          Text(_currentUser!.email),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _handleSignOut,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Sign Out', style: TextStyle(fontSize: 18)),
          ),
        ],
      );
    } else {
      // User is not signed in.
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const Text(
          //   'You are not signed in.',
          //   style: TextStyle(fontSize: 20),
          // ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _handleSignIn,
            // icon: Image.asset(
            //   'assets/images/google_logo.png',
            //   // You'll need to add a Google logo asset
            //   height: 24,
            // ),
            label: const Text(
              'Sign In with Google',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
            ),
          ),
          const SizedBox(height: 10),
          // const Text(
          //   'Make sure you have an "assets/images/google_logo.png" image for the button.',
          //   style: TextStyle(fontSize: 12, color: Colors.grey),
          //   textAlign: TextAlign.center,
          // ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBody(),
              const SizedBox(height: 40),
              // Display status/error message
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      _message.startsWith('Error') ? Colors.red : Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
