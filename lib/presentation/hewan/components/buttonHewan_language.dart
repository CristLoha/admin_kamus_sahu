import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infrastructure/theme/theme.dart';

class ButtonLanguageHewan extends StatelessWidget {
  const ButtonLanguageHewan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Material(
        borderRadius: BorderRadius.circular(14),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sahu",
                  style: darkBlueTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(EvaIcons.swapOutline),
                    ),
                  ),
                ),
                Text(
                  "Indonesia",
                  style: darkBlueTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
