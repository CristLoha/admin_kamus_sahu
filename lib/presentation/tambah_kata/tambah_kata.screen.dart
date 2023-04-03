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
      appBar: AppBar(
        backgroundColor: shamrockGreen,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
        title: Text(
          'Tambah Kata',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: semiBold,
          ),
        ),
      ),
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
                      ///CONTENT
                      Padding(
                        padding:
                            EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
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
