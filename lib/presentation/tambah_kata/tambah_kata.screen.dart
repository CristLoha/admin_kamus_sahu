import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/utils/extension/img_string.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/theme.dart';
import '../../widgets/app_input.dart';
import '../../widgets/title_input.dart';
import 'components/form_upload.dart';
import 'controllers/tambah_kata.controller.dart';

class TambahKataScreen extends GetView<TambahKataController> {
  const TambahKataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: shamrockGreen,
        title: Text(
          'Tambah Kata',
          style: whiteTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowIosBack),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 240.w,
              color: shamrockGreen,
            ),
            Center(
              child: Container(
                width: 327.w,
                height: 540.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  color: white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 22, right: 22, top: 22),
                  child: SingleChildScrollView(
                    child: FormUploadAdd(),
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
