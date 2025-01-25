import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event){
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Customize as needed
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }
  Widget _googleSignInButton(){
    return Center(child: SizedBox(
      height: 50, 
      child: SignInButton(Buttons.Google, text: "Sign up with Google", onPressed: _handleGoogleSignIn/*(){}*/),));
  }
  Widget _userInfo(){
    return SizedBox();
  }
  void _handleGoogleSignIn(){
    try{
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    }
    catch(error){
      // ignore: avoid_print
      print(error);
    }
  }
}

/*import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Customize as needed
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Return to the previous page
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color
            foregroundColor: Colors.white, // Button text color
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
          ),
          child: const Text(
            'Return to Main',
            style: TextStyle(fontSize: 16), // Customize text size
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/