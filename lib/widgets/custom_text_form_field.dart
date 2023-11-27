import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.onChanged,
    required this.labelText,
    this.isObscureText = false,
  });

  final String labelText;
  final Function(String)? onChanged;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      validator: (data){
        if(data!.isEmpty){
          return 'Field is required';
        }
      },
      onChanged: onChanged,
      keyboardType: getKeyboardType(),
        cursorColor: Colors.white,
        decoration:  InputDecoration(
          enabledBorder:const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          errorBorder: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle:const TextStyle(
              color: Colors.white
          ),
        )
    );
  }

  TextInputType getKeyboardType(){
    if(labelText.toLowerCase().contains('email')){
      return TextInputType.emailAddress;
    }else if(labelText.toLowerCase().contains('password')){
      return TextInputType.visiblePassword;
    }else{
      return TextInputType.multiline;
    }
  }
}
