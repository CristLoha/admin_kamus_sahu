import 'package:admin_kamus_sahu/presentation/splash_screen/components/footer_splash.dart';
import 'package:admin_kamus_sahu/presentation/splash_screen/components/loading_splash.dart';
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
        body: GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            260.heightBox,
            const SplashLogo(),
            const SplashLoading(),
            const FooterSplash(),
          ],
        );
      },
    ));
  }
}
