import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../infrastructure/navigation/routes.dart';
import '../infrastructure/theme/theme.dart';
import '../presentation/hewan/controllers/hewan.controller.dart';

class PopMenuButtonList extends StatelessWidget {
  const PopMenuButtonList({
    super.key,
    required this.c,
    required this.d,
  });

  final HewanController c;
  final DocumentSnapshot<Object?>
      d; // Ganti tipe data dari d menjadi DocumentSnapshot<Object?>

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) async {
        if (value == 'edit') {
          Get.toNamed(Routes.edit);
        } else if (value == 'hapus') {
          c.deleteHewan(d.id);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit', style: darkBlueTextStyle),
        ),
        PopupMenuItem<String>(
          value: 'hapus',
          child: Text('Hapus', style: darkBlueTextStyle),
        ),
      ],
    );
  }
}
