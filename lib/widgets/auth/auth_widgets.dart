import 'dart:io';

import 'package:chat/widgets/auth/image_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthWidgets extends StatefulWidget {
  bool isItSignIn;
  final void Function({
    File? image,
    String? name,
    String? email,
    String? pass,
    String? number,
    BuildContext? ctx,
  }) submitFN;
  final void Function(bool isChanged) anyChange;
  AuthWidgets(this.isItSignIn, this.submitFN, this.anyChange, {Key? key})
      : super(key: key);

  @override
  _AuthWidgetsState createState() => _AuthWidgetsState();
}

class _AuthWidgetsState extends State<AuthWidgets> {
  final formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _passController;
  // TextEditingController? _conPassController;
  TextEditingController? _phoneNumController;

  String name = '';
  String email = '';
  String pass = '';
  String conPass = '';
  String phoneNum = '';
  File? _image;

  void getImage(File? image) {
    _image = image!;
  }

  bool get isItChanged {
    return widget.isItSignIn;
  }

  void tryToSubmit() {
    if (!widget.isItSignIn) {
      if (_image == null) {
        return;
      }
    }

    final validate = formKey.currentState!.validate();
    if (validate == false) {
      return;
    }
    formKey.currentState!.save();

    widget.submitFN(
      image: _image,
      ctx: context,
      name: name,
      email: email,
      pass: pass,
      number: phoneNum,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceRatio = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width > 400
        ? 600
        : deviceRatio.width * 0.95;
    // double height = widget.isItSignIn
    //     ? deviceRatio.height * 0.40
    //     : deviceRatio.height * 0.72;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        if (widget.isItSignIn == false)
                          PickImage(
                            getImage: getImage,
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (widget.isItSignIn == false)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: _TextFieldBuilder(
                              key: 'Name',
                              controller: _nameController,
                              icon: Icons.person,
                              context: context,
                              width: width,
                              text: const Text('Name'),
                              validator: (value) {
                                if (value == null || value.length < 3) {
                                  return 'please enter valid name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                name = value!;
                              },
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: _TextFieldBuilder(
                            key: 'Email',
                            keyType: TextInputType.emailAddress,
                            controller: _emailController,
                            icon: Icons.email_sharp,
                            context: context,
                            width: width,
                            text: const Text('Email'),
                            validator: (value) {
                              if (value == null ||
                                  !value.contains('@') ||
                                  !value.contains('.com') ||
                                  value.length < 6) {
                                return 'please enter valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: _TextFieldBuilder(
                            key: 'Pass',
                            hidePass: true,
                            keyType: TextInputType.visiblePassword,
                            controller: _passController,
                            icon: Icons.password_rounded,
                            context: context,
                            width: width,
                            text: const Text('Password'),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return 'please enter valid password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              pass = value!;
                            },
                            // onEditingComplete: (value) {
                            //   pass = value;
                            // },
                          ),
                        ),
                        if (widget.isItSignIn == false)
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 5, horizontal: 5),
                          //   child: _TextFieldBuilder(
                          //     key: 'conPass',
                          //     hidePass: true,
                          //     controller: _conPassController,
                          //     icon: Icons.password_rounded,
                          //     context: context,
                          //     width: width,
                          //     text: const Text('Confirm Password'),
                          //     validator: (value) {
                          //       if (value == null || value.length < 8) {
                          //         return 'please enter valid pass';
                          //       }
                          //       if (value != pass) {
                          //         return 'no match';
                          //       }
                          //       return null;
                          //     },
                          //     onSaved: (value) {
                          //       conPass = value!;
                          //     },
                          //   ),
                          // ),
                          if (widget.isItSignIn == false)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: _TextFieldBuilder(
                                  key: 'Phone',
                                  controller: _phoneNumController,
                                  icon: Icons.phone_iphone_rounded,
                                  context: context,
                                  width: width,
                                  text: const Text('Phone Number'),
                                  validator: (value) {
                                    if (value == null || value.length != 11) {
                                      return 'please enter valid number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    phoneNum = value!;
                                  }),
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(31, 0, 85, 1),
                            ),
                          ),
                          onPressed: tryToSubmit,
                          child: widget.isItSignIn
                              ? const Text('Sign in')
                              : const Text('Sign up'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.isItSignIn = !widget.isItSignIn;
                            });
                            widget.anyChange(widget.isItSignIn);
                          },
                          child: widget.isItSignIn
                              ? const Text(
                                  'I don\'t have an account',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 121, 72, 0)),
                                )
                              : const Text(
                                  'I have an Account',
                                  style: TextStyle(
                                      color: Color.fromRGBO(31, 0, 85, 1)),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _TextFieldBuilder({
    required BuildContext context,
    double? width,
    IconData? icon,
    Widget? text,
    TextInputType? keyType,
    String? key,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
    bool hidePass = false,
    FormFieldSetter<String>? onSaved,
    ValueChanged<String>? onEditingComplete,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Align(alignment: Alignment.bottomCenter, child: Icon(icon)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).canvasColor,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextFormField(
              key: Key(key!),
              obscureText: hidePass,
              controller: controller,
              cursorColor: Theme.of(context).canvasColor,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                label: text,
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
              keyboardType: keyType,
              validator: validator,
              onSaved: onSaved,
              onFieldSubmitted: onEditingComplete,
            ),
          ),
        )
      ],
    );
  }
}
