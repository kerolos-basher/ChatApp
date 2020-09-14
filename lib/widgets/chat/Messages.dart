import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../chat/PoppleMessage.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // ignore: deprecated_member_use
        stream: Firestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, datasnapshot) {
          if (datasnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var docs = datasnapshot.data.documents;
           
          return ListView.builder(
              reverse: true,
              itemBuilder: (ctx, i) => PoppleMessage(
                  docs[i].data()['text'],
                  docs[i].data()['userId'] ==
                      FirebaseAuth.instance.currentUser.uid,
                     docs[i].data()['username'],
                     docs[i].data()['img_url'],
                  key: ValueKey(docs[i].documentID)),
              itemCount: docs.length);
        });
  }
}
