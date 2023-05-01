import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  void logout() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Keluar',
      desc: 'Apakah anda yakin ingin keluar?',
      btnCancelOnPress: () => Get.back(),
      btnCancelText: 'Kembali',
      btnOkText: 'Oke',
      btnOkOnPress: () async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
            awesomeDialogFailed(
                'Tidak ada Internet', 'Silahkan periksa koneksi internet Anda');
            return;
          }

          await auth.signOut();
          Get.offAllNamed(Routes.login);
        } catch (e) {
          awesomeDialogFailed('Gagal keluar', 'Anda telah gagal keluar');
        }
      },
    ).show();
  }

  void awesomeDialogSuccess() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Berhasil Keluar',
      desc: 'Anda telah berhasil keluar',
      btnOkText: 'Oke',
      btnOkOnPress: () {
        Get.back();
      },
      dismissOnTouchOutside: false,
    ).show();
  }

  void awesomeDialogFailed(String title, String desc) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnOkText: 'Oke',
      btnOkOnPress: () {
        Get.back();
      },
      dismissOnTouchOutside: false,
    ).show();
  }
}
