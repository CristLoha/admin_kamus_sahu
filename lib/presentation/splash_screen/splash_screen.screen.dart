import 'package:admin_kamus_sahu/presentation/splash_screen/controllers/footer_splash.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/splash_logo.dart';
import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        281.heightBox,
        SplashLogo(),
        291.heightBox,
        FooterSplash(),
      ],
    ));
  }
}
