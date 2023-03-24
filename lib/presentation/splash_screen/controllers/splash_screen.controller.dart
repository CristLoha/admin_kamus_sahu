import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.home);
    });
  }
}
