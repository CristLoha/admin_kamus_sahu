import 'package:get/get.dart';

import '../../../../presentation/tambah_kata/controllers/tambah_kata.controller.dart';

class TambahKataControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahKataController>(
      () => TambahKataController(),
    );
  }
}
