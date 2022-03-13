import 'package:chat/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:chat/helpers/enum_helpers.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isItSignIn = true;

  void submitFUN({
    String? name,
    String? email,
    String? pass,
    double? number,
  }) {}

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
