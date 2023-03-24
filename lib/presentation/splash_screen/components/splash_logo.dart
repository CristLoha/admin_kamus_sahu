import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/extension/img_string.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: const AssetImage(ImgString.logoSahu),
        width: 154.w,
      ),
    );
  }
}
