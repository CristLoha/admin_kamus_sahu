import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/widgets/app_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Reset Audio',
                                style: darkBlueTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: bold,
                                )),
                            content: Text(
                                'Anda yakin ingin mereset audio yang sudah dipilih?',
                                style: darkGrayTextStyle.copyWith(
                                  fontSize: 13,
                                )),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Batal',
                                    style: darkGrayTextStyle.copyWith(
                                        fontWeight: medium, fontSize: 13)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.resetAudio();
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: shamrockGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  minimumSize: const Size(100.0, 40.0),
                                ),
                                child: Text('Reset',
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 13, fontWeight: medium)),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      controller.pickAudio();
                    }
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(EvaIcons.upload)),
                ),
              ),
              8.widthBox,
              Flexible(
                flex: 1,
                child: Text(
                  controller.isSelected.value
                      ? controller.audioFileName
                      : 'Audio belum dipilih',
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

        22.heightBox,
        AppButton(
          text: 'Kirim',
          onPressed: () {
            controller.uploadAudioToFirebase();
          },
        ),
      ],
    );
  }
}
