import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/tambah_kata/controllers/tambah_kata.controller.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;

  final Widget? prefixIcon;
  final bool? obscureText;

  final TambahKataController c = Get.put(TambahKataController());
  AppInput({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Harap diisi";
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            14,
          ),
          borderSide: const BorderSide(
            color: oldRose,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            14,
          ),
          borderSide: const BorderSide(
            color: oldRose,
          ),
        ),
      ),
    );
  }
}
