import 'package:get/get.dart';

import '../../../../presentation/hewan/controllers/hewan.controller.dart';

class HewanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HewanController>(
      () => HewanController(),
    );
  }
}
