import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/utils/extension/img_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            ImgString.logoSahu,
            width: 154.w,
            height: 60.h,
          ),
        ),
        70.heightBox,
        Text(
          'Silahkan Isi Email dan\nKata Sandi',
          style: darkBlueTextStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: semiBold,
          ),
        ),
      ],
    );
  }
}
