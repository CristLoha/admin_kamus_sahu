import 'package:admin_kamus_sahu/presentation/tambah_kata/controllers/tambah_kata.controller.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/extension/img_string.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/title_input.dart';

class FormUploadAdd extends StatelessWidget {
  final TambahKataController tambahKataController =
      Get.put(TambahKataController());
  FormUploadAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TittleInput(
          text: 'Kata Sahu',
        ),
        8.heightBox,
        const AppInput(),
        16.heightBox,
        const TittleInput(
          text: 'Contoh Kata Bahasa Sahu',
        ),
        8.heightBox,
        const AppInput(),
        16.heightBox,
        ////
        const TittleInput(
          text: 'Kata Indonesia',
        ),
        8.heightBox,
        const AppInput(),
        16.heightBox,
        const TittleInput(
          text: 'Contoh Kata Bahasa Indonesia',
        ),
        8.heightBox,
        const AppInput(),
        16.heightBox,
        const TittleInput(
          text: 'Unggah Suara Wanita',
        ),
        8.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImgString.imgUpload,
                    width: 24,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.play_arrow),
                    ),
                  ),
                ),
                10.widthBox,
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.pause),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        16.heightBox,
        const TittleInput(
          text: 'Unggah Suara Wanita',
        ),
        8.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImgString.imgUpload,
                    width: 24,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.play_arrow),
                    ),
                  ),
                ),
                10.widthBox,
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.pause),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        22.heightBox,
      ],
    );
  }
}
