import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/widgets/text_underline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../infrastructure/theme/theme.dart';
import '../../utils/extension/lottie_string.dart';
import '../../widgets/app_search.dart';
import 'components/button_hewan_language.dart';
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
                            padding: const EdgeInsets.only(
                              left: 22,
                              right: 22,
                              top: 30,
                              bottom: 10,
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: controller.getHewan(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var dataList = snapshot.data!.docs.toList();
                                  String removeUnderscore(String text) {
                                    if (text.startsWith('_')) {
                                      return text.substring(1);
                                    }
                                    return text;
                                  }

                                  // Urutkan data berdasarkan field 'kataIndonesia' atau 'kataSahu'

                                  if (controller.isSahu.value) {
                                    dataList.sort((a, b) => removeUnderscore(
                                            a['kataSahu'])
                                        .compareTo(
                                            removeUnderscore(b['kataSahu'])));
                                  } else {
                                    dataList.sort((a, b) =>
                                        removeUnderscore(a['kataIndonesia'])
                                            .compareTo(removeUnderscore(
                                                b['kataIndonesia'])));
                                  }

                                  return Column(
                                    children: [
                                      ButtonLanguageHewan(),
                                      30.heightBox,
                                      const AppSearch(),
                                      30.heightBox,
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.hasData
                                            ? dataList.length
                                            : 5,
                                        itemBuilder: (context, index) {
                                          var data = dataList[index];
                                          return Obx(
                                            () => Material(
                                              color: white,
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 16),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: whisper),
                                                ),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {},
                                                  child: ListTile(
                                                    trailing:
                                                        PopupMenuButton<String>(
                                                      onSelected:
                                                          (String value) async {
                                                        if (value == 'edit') {
                                                          Get.toNamed(
                                                              Routes.edit);
                                                        } else if (value ==
                                                            'hapus') {
                                                          controller
                                                              .deleteHewan(
                                                                  data.id);
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          <
                                                              PopupMenuEntry<
                                                                  String>>[
                                                        PopupMenuItem<String>(
                                                          value: 'edit',
                                                          child: Text('Edit',
                                                              style:
                                                                  darkBlueTextStyle),
                                                        ),
                                                        PopupMenuItem<String>(
                                                          value: 'hapus',
                                                          child: Text('Hapus',
                                                              style:
                                                                  darkBlueTextStyle),
                                                        ),
                                                      ],
                                                    ),
                                                    title: UnderlineText(
                                                      text: controller
                                                              .isSahu.value
                                                          ? data['kataSahu']
                                                              .toString()
                                                          : data['kataIndonesia']
                                                              .toString(),
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: darkBlue,
                                                      ),
                                                    ),
                                                    subtitle: UnderlineText(
                                                      text: controller
                                                              .isSahu.value
                                                          ? data['kataIndonesia']
                                                              .toString()
                                                          : data['kataSahu']
                                                              .toString(),
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: shamrockGreen,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
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
