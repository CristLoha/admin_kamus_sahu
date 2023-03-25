import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    changeStatusBarColor(darkGreen); // Ubah warna status bar
    changeNavigationBarColor(Colors.white); // Ubah warna navigasi bar
  }

  void changeStatusBarColor(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  void changeNavigationBarColor(Color color) async {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }
}
