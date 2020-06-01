import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    AuthResult authResult;
    if (isLogin) {
      authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
