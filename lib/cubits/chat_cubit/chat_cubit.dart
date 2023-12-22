import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  sendMessage({required String message, required String email}) {
    if (message.isNotEmpty) {
      messages.add({
        kMessageKey: message,
        kCreatedAtKey: DateTime.now(),
        kSenderEmailKey: email,
      });

      print("Message sent");
    }
  }

  getMessages() {
    messages
        .orderBy(kCreatedAtKey, descending: true)
        .snapshots()
        .listen((event) {
      List<MessageModel> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }
      print('Show messages done');
      emit(ChatSendingSuccess(messagesList: messagesList));
    });
  }
}
