import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
import '../controllers/tambah_kata.controller.dart';

class AppWidgetAudioWanita extends StatelessWidget {
  final TambahKataController cW = Get.put(TambahKataController());
  AppWidgetAudioWanita({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                if (cW.isSelectedWanita.value) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Reset Audio Wanita',
                            style: darkBlueTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            )),
                        content: Text(
                            'Anda yakin ingin mereset audio wanita yang sudah dipilih?',
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
                              cW.resetAudioWanita();
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
                  cW.pickAudioWanita();
                }
              },
              child: const Padding(
                  padding: EdgeInsets.all(8.0), child: Icon(EvaIcons.upload)),
            ),
          ),
          8.widthBox,
          Flexible(
            flex: 1,
            child: Text(
              cW.isSelectedWanita.value
                  ? cW.audioFileNameWanita
                  : 'Audio belum dipilih',
              style: darkGrayTextStyle.copyWith(fontWeight: medium),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (cW.isSelectedWanita.value)
            IconButton(
              onPressed: () => cW.resetAudioWanita(),
              icon: const Icon(
                EvaIcons.trash,
                color: oldRose,
              ),
            )
        ],
      ),
    );
  }
}
