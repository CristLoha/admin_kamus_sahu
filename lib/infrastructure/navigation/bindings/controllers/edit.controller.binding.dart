import 'package:get/get.dart';

import '../../../../presentation/edit/controllers/edit.controller.dart';

class EditControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditController>(
      () => EditController(),
    );
  }
}
