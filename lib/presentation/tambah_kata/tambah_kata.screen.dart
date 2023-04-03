import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/theme.dart';
import 'components/form_upload.dart';
import 'controllers/tambah_kata.controller.dart';

class TambahKataScreen extends GetView<TambahKataController> {
  const TambahKataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 240.w,
                  color: shamrockGreen,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      ///NAVBAR
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.w, top: 20.h, right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                EvaIcons.arrowIosBack,
                                color: white,
                              ),
                              onPressed: () => Get.back(),
                            ),
                            Expanded(
                              child: Text(
                                'Tambah Kata',
                                textAlign: TextAlign.center,
                                style: whiteTextStyle.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                            130.widthBox,
                          ],
                        ),
                      ),
                      40.heightBox,

                      ///CONTENT
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            color: white,
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 30.h, horizontal: 22.h),
                              child: FormUploadAdd()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            40.heightBox,
          ],
        ),
      ),
    );
  }
}
