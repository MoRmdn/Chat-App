import 'package:chat/widgets/auth_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isItSignIn = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  void submitFUN({
    String? name,
    String? email,
    String? pass,
    double? number,
    BuildContext? ctx,
  }) async {
    try {
      if (_isItSignIn) {
        userCredential = await auth.signInWithEmailAndPassword(
          email: email!,
          password: pass!,
        );
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email!, password: pass!);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      String message = 'error has been occurs';
      if (e.code == 'weak-password') {
        message = 'your password is weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'this email has an account try to sign in';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(ctx!).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e2) {
      print(e2);
    }
  }

  void anyChange(bool signIn) {
    if (signIn != _isItSignIn) {
      setState(() {
        _isItSignIn = signIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_isItSignIn ? 'Sign in' : 'Sign up'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthWidgets(_isItSignIn, submitFUN, anyChange),
    );
  }
}
