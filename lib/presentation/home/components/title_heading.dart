import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class TitleHeadingHome extends StatelessWidget {
  const TitleHeadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30),
      child: RichText(
        text: TextSpan(
            style: darkBlueTextStyle.copyWith(fontSize: 20),
            children: [
              TextSpan(
                text: 'Pilih salah satu kategori\ndi bawah ini ',
                style: TextStyle(fontWeight: semiBold),
              ),
              TextSpan(
                text: 'untuk melihat\ndaftar kata-kata',
                style: TextStyle(fontWeight: light, color: slateGrey),
              ),
            ]),
      ),
    );
  }
}
