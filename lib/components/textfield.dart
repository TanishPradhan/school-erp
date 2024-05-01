import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  const CommonTextField({super.key, required this.controller, this.textInputAction, this.obscureText, this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    // String? _errorText() {
    //   final text = controller.value.text;
    //
    //   if (text.isEmpty) {
    //     return "Required *";
    //   }
    //   return null;
    // }


    return TextField(
      controller: controller,
      cursorColor: primaryColor,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      obscureText: obscureText ?? false,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        // errorText: _errorText(),
      ),
    );
  }
}
