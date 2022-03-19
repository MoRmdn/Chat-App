import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _db = FirebaseFirestore.instance;
  final newMessageController = TextEditingController();
  var theMessage = '';

  void sendMessage() {
    FocusScope.of(context).unfocus();
    _db.collection('/chat/').add({
      'text': theMessage,
      'createdAT': Timestamp.now(),
    });
    newMessageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
