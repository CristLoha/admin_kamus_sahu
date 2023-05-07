import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/widgets/text_underline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/controller/aho_corasick.dart';
import '../../domain/models/filter_snapshot.dart';
import '../../infrastructure/theme/theme.dart';
import '../../widgets/app_search.dart';
import '../../widgets/cirucular_progress_indicator.dart';
import '../../widgets/title_appbar.dart';
import 'components/button_hewan_language.dart';
import '../../widgets/pop_menu_list.dart';
import 'controllers/hewan.controller.dart';

class HewanScreen extends GetView<HewanController> {
  final AhoCorasickController _ahoC = Get.put(AhoCorasickController());
  HewanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shamrockGreen,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
        title: const TittleAppBar(title: 'Kata Hewan'),
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
                            child: StreamBuilder(
                              stream: controller.getHewanStream(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          FilteredQuerySnapshot<
                                              Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  var dataList = snapshot.data!.docs
                                      .cast<
                                          QueryDocumentSnapshot<
                                              Map<String, dynamic>>>()
                                      .toList();

                                  _ahoC.initAhoCorasickWithSnapshot(
                                      dataList, controller.isSahu.value);

                                  return Column(
                                    children: [
                                      ButtonLanguageHewan(
                                          controller: controller),

                                      30.heightBox,

                                      /// ini widget yang tadi
                                      const AppSearch(),
                                      30.heightBox,
                                      Obx(() {
                                        // Konversi tipe data menjadi Map<String, dynamic>
                                        var dataList = snapshot.data!.docs
                                            .cast<
                                                QueryDocumentSnapshot<
                                                    Map<String, dynamic>>>()
                                            .toList();
                                        var filteredDataList =
                                            controller.filterDataList(dataList,
                                                controller.searchText.value);

                                        // Urutkan data berdasarkan teks utama (Sahu atau Indonesia) sebelum membangun ListView
                                        filteredDataList.sort((a, b) {
                                          String aText = controller.isSahu.value
                                              ? a['kataSahu'].toString()
                                              : a['kataIndonesia'].toString();
                                          String bText = controller.isSahu.value
                                              ? b['kataSahu'].toString()
                                              : b['kataIndonesia'].toString();
                                          aText = aText
                                              .toLowerCase()
                                              .replaceAll('_', '');
                                          bText = bText
                                              .toLowerCase()
                                              .replaceAll('_', '');
                                          return aText.compareTo(bText);
                                        });

                                        if (filteredDataList.isNotEmpty) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: filteredDataList.length,
                                            itemBuilder: (context, index) {
                                              var data =
                                                  filteredDataList[index];
                                              return Obx(
                                                () {
                                                  // Jika bahasa adalah Sahu, tampilkan kata Sahu terlebih dahulu
                                                  String primaryText =
                                                      controller.isSahu.value
                                                          ? data['kataSahu']
                                                              .toString()
                                                          : data['kataIndonesia']
                                                              .toString();
                                                  String secondaryText =
                                                      controller.isSahu.value
                                                          ? data['kataIndonesia']
                                                              .toString()
                                                          : data['kataSahu']
                                                              .toString();
                                                  return Material(
                                                    color: white,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 16),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: whisper),
                                                      ),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        onTap: () {
                                                          Get.toNamed(
                                                              Routes.detail,
                                                              arguments: data);
                                                        },
                                                        child: ListTile(
                                                          trailing:
                                                              PopMenuButtonList(
                                                                  c: controller,
                                                                  d: data),
                                                          title: UnderlineText(
                                                            text: primaryText,
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: darkBlue,
                                                            ),
                                                          ),
                                                          subtitle:
                                                              UnderlineText(
                                                            text: secondaryText,
                                                            textStyle:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .blueGrey,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          return const Text(
                                            'Data tidak ditemukan',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      }),
                                    ],
                                  );
                                } else {
                                  return const CircularProgressWidget();
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
