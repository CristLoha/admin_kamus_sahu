import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

import '../../../app/controller/connection.controller.dart';

class SplashScreenController extends GetxController {
  final ConnectivityController connectivityController =
      Get.find<ConnectivityController>();

  @override
  void onReady() {
    super.onReady();
    ever(connectivityController.hasConnection, (isConnected) async {
      if (isConnected) {
        await Future.delayed(const Duration(seconds: 4));
        Get.offAllNamed(Routes.login);
      }
    });
  }
}
