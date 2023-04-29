import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController(text: 'admin@gmail.com');
  TextEditingController passC = TextEditingController(text: 'admin12345');

  void login() async {
    // Pastikan ada koneksi internet
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      infoFailed(
          "Tidak ada Internet", "Silahkan periksa koneksi internet Anda");
      return;
    }
    easyLoadingCustom();
    await EasyLoading.show(status: 'Memuat..');

// To hide loading indicator:
    EasyLoading.dismiss();
    // Get.offAllNamed(Routes.home);
    Get.toNamed(Routes.home);
  }

  void infoFailed(String msg1, String msg2) {
    Get.snackbar(
      "",
      "",
      backgroundColor: oldRose,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(0),
      borderRadius: 0,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 600),
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      showProgressIndicator: false,
      overlayBlur: 0.0,
      overlayColor: darkBlue,
      icon: const Icon(
        EvaIcons.alertCircleOutline,
        color: white,
      ),
      shouldIconPulse: true,
      leftBarIndicatorColor: oldRose,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        msg1,
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
      messageText: Text(
        msg2,
        style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 12),
      ),
    );
  }

  void infoSuccess(String msg1, String msg2) {
    Get.snackbar(
      "",
      "",
      backgroundColor: shamrockGreen,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(0),
      borderRadius: 0,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 600),
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      showProgressIndicator: false,
      overlayBlur: 0.0,
      overlayColor: white, // Menggunakan warna putih
      icon: const Icon(
        EvaIcons.checkmarkCircle2Outline,
        color: white,
      ),
      shouldIconPulse: true,
      leftBarIndicatorColor: shamrockGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        msg1,
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
      messageText: Text(
        msg2,
        style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 12),
      ),
    );
  }

  void easyLoadingCustom() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 2)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 8.0
      ..progressColor = white
      ..backgroundColor = shamrockGreen
      ..indicatorColor = white
      ..textColor = white
      ..textStyle = whiteTextStyle
      ..maskColor = shamrockGreen.withOpacity(0.10)
      ..userInteractions = true
      ..dismissOnTap = false;
  }
}
