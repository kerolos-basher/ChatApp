import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PoppleMessage extends StatelessWidget {
  final message;
  bool isMe;
  final userName;
  String imgurl;
  final Key key;

  PoppleMessage(this.message, this.isMe, this.userName, this.imgurl,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: isMe
                      ? Colors.deepPurple[600]
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          !isMe ? Radius.circular(20) : Radius.circular(12),
                      topRight:
                          isMe ? Radius.circular(20) : Radius.circular(12),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(12))),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(message,
                      style: TextStyle(color: Colors.white),
                      textAlign: isMe ? TextAlign.end : TextAlign.start),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: isMe ? 120 : null,
          left: !isMe ? 120 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(imgurl)),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
