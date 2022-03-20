import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/chat/')
            .orderBy('createdAT', descending: true)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapShot.hasData) {
            return Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.sentiment_satisfied_alt,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Say Hello',
                  ),
                ],
              ),
            );
          } else {
            List<DocumentSnapshot> documents = snapShot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) {
                return
                    //Text(documents[index]['text']);

                    ///
                    MessageBubble(
                  key: ValueKey(documents[index].id),
                  message: documents[index]['text'],
                  isME: user!.uid == documents[index]['userID'],
                  userName: documents[index]['userName'],
                );
              },
            );
          }
        });
  }
}
