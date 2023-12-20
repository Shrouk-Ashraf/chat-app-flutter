import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../helper/show_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: CircularProgressIndicator(
        color: Colors.blue,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'assets/images/scholar_img.png',
                  height: 100,
                ),
                const Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  labelText: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  isObscureText: true,
                  labelText: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    onTap: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context,
                              message: 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              message:
                                  'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, message: e.toString());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    buttonText: "Sign Up"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account ?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: kSecondaryColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
