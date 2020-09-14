import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  final _controller = new TextEditingController();
  var _enterdMessage = '';
  void _sendMessage() async
  {
   FocusScope.of(context).unfocus();
   final user = FirebaseAuth.instance.currentUser;
    // ignore: deprecated_member_use
       final userdata = await Firestore.instance.collection('users').document(user.uid).get();
    // ignore: deprecated_member_use
    Firestore.instance.collection('chat').add({
  'text':_enterdMessage,
  'createdAt':Timestamp.now(),
  'userId': user.uid,
  'username':userdata.data()['username'],
  'img_url' : userdata.data()['img_url']

    });
    setState(() {
      _enterdMessage='';
       _controller.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Send Message ...'),
                autocorrect: true,
                 textCapitalization: TextCapitalization.sentences,
                 enableSuggestions: true,
                 
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _enterdMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _enterdMessage.trim().isEmpty ? null :_sendMessage,
          
          )
        ],
      ),
    );
  }
}
