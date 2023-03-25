import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            style: darkGrayTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Version 1.0',
            style: lightGrayTextStyle.copyWith(
              fontSize: 10.sp,
              fontWeight: medium,
            ),
          ),
        ),
        25.heightBox,
      ],
    );
  }
}
