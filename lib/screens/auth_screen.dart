import 'dart:io';

import 'package:chat/widgets/auth/auth_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isItSignIn = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  void submitFUN({
    File? image,
    String? name,
    String? email,
    String? pass,
    String? number,
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
        final ref = _storage
            .ref()
            .child('users_images')
            .child(userCredential!.user!.uid + '.jpg');
        // upload image
        await ref.putFile(image!);
        // get image url
        final downloadURL = await ref.getDownloadURL();

        /// add to DataBase
        _db.collection('/users/').doc(userCredential!.user!.uid).set({
          'Name': name,
          'Email': email,
          'PhoneNum': number,
          'imageURL': downloadURL
        });
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
      // ignore: avoid_print
      print(e2);
    }
  }

  void anyChange(bool signIn) {
    if (signIn != _isItSignIn) {
      setState(() {
        _isItSignIn = signIn;
      });
    }
    // ignore: avoid_print
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
