part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSendingSuccess extends ChatState {
  final List<MessageModel> messagesList;

  ChatSendingSuccess({required this.messagesList});
}
