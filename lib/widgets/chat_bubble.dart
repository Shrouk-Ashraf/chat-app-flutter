import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message,
    required this.isSender,
    super.key,
  });
  final MessageModel message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:isSender? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:isSender? kPrimaryColor : kReceiverColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: isSender ?Radius.circular(32) : Radius.zero,
            bottomLeft: isSender? Radius.zero: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
    );
  }
}