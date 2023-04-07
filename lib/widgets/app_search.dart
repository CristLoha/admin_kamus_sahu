import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/controller/aho_corasick.dart';
import '../infrastructure/theme/theme.dart';

class AppSearch extends StatelessWidget {
  final AhoCorasickController _ahoC = Get.put(AhoCorasickController());

  AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(14),
      child: TextFormField(
        onChanged: (value) {
          _ahoC.search(value);
        },
        cursorColor: darkBlue,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, bottom: 20),
          hintStyle: slateGreyTextStyle,
          prefixIcon: const Icon(
            EvaIcons.searchOutline,
            color: darkGray,
          ),
          hintText: 'Cari kata',
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              14,
            ),
            borderSide: const BorderSide(
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
