import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  String? message;

  List<MessageModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                height: 45,
              ),
              Text(
                'Chat',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSendingSuccess) {
                    messagesList = state.messagesList;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          message: messagesList[index],
                          isSender: email == messagesList[index].senderEmail,
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                onChanged: (data) {
                  message = data;
                },
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (message != null) {
                        BlocProvider.of<ChatCubit>(context)
                            .sendMessage(message: message!, email: email);
                        controller.clear();
                        message = null;
                        scrollController.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    icon: Icon(Icons.send),
                    color: kPrimaryColor,
                  ),
                  hintText: 'Send Message',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
              ),
            ),
          ],
        ));
  }
}
