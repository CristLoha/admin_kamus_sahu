import 'package:admin_kamus_sahu/utils/extension/lottie_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: Get.width * 0.5.w,
          height: Get.width * 0.5.h,
          child: Lottie.asset(LottieString.loading),
        ),
      ),
    );
  }
}
