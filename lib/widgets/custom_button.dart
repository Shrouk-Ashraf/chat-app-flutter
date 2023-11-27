import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.onTap,required this.buttonText,Key? key}) : super(key: key);

  final String buttonText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
