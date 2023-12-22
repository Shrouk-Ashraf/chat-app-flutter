import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) {
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          );
        },
        RegisterPage.id: (context) => BlocProvider(
              create: (context) => RegisterCubit(),
              child: const RegisterPage(),
            ),
        ChatPage.id: (context) => BlocProvider(
              create: (context) => ChatCubit()..getMessages(),
              child: ChatPage(),
            ),
      },
      initialRoute: LoginPage.id,
    );
  }
}
