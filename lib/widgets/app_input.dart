import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool? obscureText;

  const AppInput({Key? key, this.controller, this.prefixIcon, this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        cursorColor: darkBlue,
        textAlign: TextAlign.start,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, bottom: 20),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: whisper,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              14,
            ),
            borderSide: const BorderSide(
              color: shamrockGreen,
            ),
          ),
        ),
      ),
    );
  }
}
