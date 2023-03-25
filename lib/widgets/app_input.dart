import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  const AppInput({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
