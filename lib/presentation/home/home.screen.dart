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
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        // Memanggil method changeStatusBarColor dan changeNavigationBarColor
        // pada saat widget dibuild untuk pertama kalinya
        controller.changeStatusBarColor(darkGreen);
        controller.changeNavigationBarColor(Colors.white);
        return Scaffold(
            backgroundColor: offWhite,
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('Kamus Bahasa Sahu'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(EvaIcons.menu2Outline),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(EvaIcons.searchOutline),
                  onPressed: () {
                    // kode untuk menampilkan halaman pencarian di sini
                  },
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
