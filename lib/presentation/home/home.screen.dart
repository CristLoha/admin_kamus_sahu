import 'package:admin_kamus_sahu/app/controller/statusbar.controller.dart';
import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/home.controller.dart';
import 'components/home_menu.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusBarController>(
      init: StatusBarController(),
      builder: (c) {
        c.changeStatusBarColor(darkGreen);
        c.changeNavigationBarColor(Colors.black);
        return Scaffold(
            backgroundColor: offWhite,
            appBar: AppBar(
              backgroundColor: shamrockGreen,
              title: const Text('Kamus Bahasa Sahu'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(EvaIcons.menu2Outline),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => controller.logout(),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.toNamed(Routes.tambahKata),
              backgroundColor: vividYellow,
              child: const Icon(Icons.add),
            ),
            body: const HomeMenu());
      },
    );
  }
}
