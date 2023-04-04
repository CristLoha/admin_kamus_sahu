import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/hewan.controller.dart';

class ButtonLanguageHewan extends StatelessWidget {
  final HewanController controller = Get.put(HewanController());

  ButtonLanguageHewan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Material(
        borderRadius: BorderRadius.circular(14),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.w),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.isSahu.value
                          ? "Sahu"
                          : "Indonesia", // render text based on the current language
                      style: darkBlueTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                      child: InkWell(
                        onTap: () {
                          controller
                              .updateLanguage(); // toggle the language when the button is tapped
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(EvaIcons.swapOutline),
                        ),
                      ),
                    ),
                    Text(
                      controller.isSahu.value
                          ? "Indonesia"
                          : "Sahu", // render text based on the current language
                      style: darkBlueTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
