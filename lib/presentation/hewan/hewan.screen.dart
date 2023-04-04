import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/widgets/text_underline.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';

import '../../widgets/app_search.dart';
import 'components/buttonHewan_language.dart';
import 'controllers/hewan.controller.dart';

class HewanScreen extends GetView<HewanController> {
  const HewanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shamrockGreen,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
        title: Text(
          'Kata Hewan',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: semiBold,
          ),
        ),
      ),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
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
                              child: Column(
                                children: [
                                  const ButtonLanguageHewan(),
                                  30.heightBox,
                                  const AppSearch(),
                                  30.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                  18.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: whisper),
                                    ),
                                    child: ListTile(
                                      trailing:
                                          const Icon(EvaIcons.volumeUpOutline),
                                      title: const UnderlineText(
                                        text: "_Boki",
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: darkBlue),
                                      ),
                                      subtitle: Text(
                                        'Kucing',
                                        style: TextStyle(
                                          color: Colors.blueGrey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
