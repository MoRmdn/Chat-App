import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/chats/').snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            print(snapShot.data);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapShot.hasData) {
            return Center(
              child: Row(mainAxisSize: MainAxisSize.min, children: const [
                Icon(Icons.sentiment_satisfied_alt),
                SizedBox(
                  width: 10,
                ),
                Text('Say Hello'),
              ]),
            );
          } else {
            List<DocumentSnapshot> documents = snapShot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) {
                return Text(documents[index]['text']);
              },
            );
          }
        });
  }
}
