import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class FooterSplash extends StatelessWidget {
  const FooterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Admin',
            style: greyTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Version 1.0',
            style: greyTextStyle2.copyWith(
              fontSize: 10,
              fontWeight: medium,
            ),
          ),
        ),
      ],
    );
  }
}