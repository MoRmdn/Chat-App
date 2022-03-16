import 'package:chat/widgets/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final _db = FirebaseFirestore.instance;
  // String authData = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        centerTitle: true,
        actions: [
          DropdownButton(
              elevation: 3,
              icon: const Icon(Icons.more_vert_rounded),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 5,
                      ),
                      Text('logout')
                    ],
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (identfire) {
                if (identfire == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      // generic type >QuerySnapshot to let flutter know that taht's stream from firebase
      body: Column(
        children: [
          Expanded(child: Messages()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _db.collection('/chats/').add({
            'text': 'Hey u have been succeeded',
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
// StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('/chats/').snapshots(),
//           builder: (ctx, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               final List<DocumentSnapshot> documents = snapshot.data!.docs;
//               return ListView.builder(
//                 itemCount: documents.length,
//                 itemBuilder: (ctx, i) {
//                   return Text(documents[i]['text']);
//                 },
//               );
//             }
//           })