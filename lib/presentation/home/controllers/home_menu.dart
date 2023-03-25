import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:admin_kamus_sahu/utils/extension/img_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 44.h, left: 24.w),
          child: Text(
            'Kategori',
            style: darkBlueTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        14.heightBox,
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              late String title;
              late String image;
              late VoidCallback onTap;

              switch (index) {
                case 0:
                  title = "Hewan";
                  image = ImgString.imgCat;
                  onTap = () {};
                  break;
                case 1:
                  title = "Benda";
                  image = ImgString.imgHammer;
                  onTap = () {};
                  break;
                case 2:
                  title = "Kerja";
                  image = ImgString.imgChat;
                  onTap = () {
                    print('OPEN CAMERA');
                  };
                  break;
                case 3:
                  title = "Tumbuhan";
                  image = ImgString.imgtree;
                  onTap = () {
                    print('OPEN PDF');
                  };
                  break;
                case 4:
                  title = "Tempat";
                  image = ImgString.imgMap;
                  onTap = () {
                    print('OPEN PDF');
                  };
                  break;
                case 5:
                  title = "Angka";
                  image = ImgString.imgNumbers;
                  onTap = () {
                    print('OPEN PDF');
                  };
                  break;
                case 6:
                  title = "Anggota Tubuh";
                  image = ImgString.imgBody;
                  onTap = () {
                    print('OPEN PDF');
                  };
                  break;
                case 7:
                  title = "Depan";
                  image = ImgString.imgEntrance;
                  onTap = () {
                    print('OPEN PDF');
                  };
                  break;

                default:
              }
              return Material(
                color: white,
                borderRadius: BorderRadius.circular(9),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 40.w, height: 40.h, child: Image.asset(image)),
                      10.heightBox,
                      Text(
                        title,
                        style: darkBlueTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
