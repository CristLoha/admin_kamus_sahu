import 'package:admin_kamus_sahu/app/controller/statusbar.controller.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/tambah_kata.controller.dart';

class TambahKataScreen extends GetView<TambahKataController> {
  const TambahKataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 240.w,
              color: shamrockGreen,
              child: Row(
                children: [],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 327.w,
                  height: 520,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: white,
                  ),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
