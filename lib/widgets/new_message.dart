import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  final newMessageController = TextEditingController();
  var theMessage = '';

  void sendMessage() async {
    final userData = await _db.collection('/users/').doc(user!.uid).get();
    FocusScope.of(context).unfocus();
    _db.collection('/chat/').add({
      'text': theMessage,
      'createdAT': Timestamp.now(),
      'userID': user!.uid,
      'userName': userData['Name']
    });
    newMessageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: newMessageController,
              decoration: const InputDecoration(
                label: Text('Enter Your Message...'),
              ),
              onChanged: (value) {
                setState(() {
                  theMessage = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: theMessage.trim().isEmpty ? null : sendMessage,
            icon: const Icon(Icons.send)),
      ],
    );
  }
}
