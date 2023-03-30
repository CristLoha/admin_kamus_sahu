import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/extension/img_string.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/title_input.dart';
import '../controllers/tambah_kata.controller.dart';

class FormUploadAdd extends StatelessWidget {
  final TambahKataController controller = Get.put(TambahKataController());

  FormUploadAdd({
    Key? key,
  }) : super(key: key);

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
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    if (controller.isSelected.value) {
                      Get.defaultDialog(
                        title: 'Reset audio',
                        middleText:
                            'Anda yakin ingin mereset audio yang sudah dipilih?',
                        onConfirm: () => controller.resetAudio(),
                      );
                    } else {
                      controller.pickAudio();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      ImgString.imgUpload,
                      width: 24,
                    ),
                  ),
                ),
              ),
              10.widthBox,
              Flexible(
                flex: 1,
                child: Text(
                  controller.isSelected.value
                      ? '${controller.audioFileName}'
                      : 'Belum ada audio dipilih',
                  style: darkBlueTextStyle.copyWith(fontWeight: medium),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (controller.isSelected.value)
                IconButton(
                  onPressed: () => controller.resetAudio(),
                  icon: const Icon(
                    EvaIcons.trash,
                    color: oldRose,
                  ),
                )
            ],
          ),
        ),

        /// nah sekarang giliran anda pasangkan fungsi untuk pemutar audio di sini =>
        22.heightBox,
      ],
    );
  }
}
