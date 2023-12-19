import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final Timestamp createdAt;
  final String senderEmail;

  MessageModel(
      {required this.message,
      required this.createdAt,
      required this.senderEmail});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      message: jsonData[kMessageKey],
      createdAt: jsonData[kCreatedAtKey],
      senderEmail: jsonData[kSenderEmailKey],
    );
  }
}
