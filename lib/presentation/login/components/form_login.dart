import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/presentation/login/controllers/login.controller.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input.dart';
import '../../../widgets/title_input.dart';

class FormLogin extends StatelessWidget {
  final LoginController c = Get.put(LoginController());
  FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: c.formKeys,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TittleInput(text: 'Alamat Email'),
              8.heightBox,
              AppInput(controller: c.emailC),
              16.heightBox,
              const TittleInput(text: 'Kata Sandi'),
              8.heightBox,
              Obx(() => AppInput(
                    controller: c.passC,
                    obscureText: c.isHidden.value,
                    suffixIcon: IconButton(
                      onPressed: () => c.isHidden.toggle(),
                      icon: c.isHidden.isFalse
                          ? const Icon(
                              FontAwesome.eye,
                              color: darkBlue,
                            )
                          : const Icon(
                              FontAwesome.eye_off,
                              color: darkBlue,
                            ),
                    ),
                  )),
              60.heightBox,
              AppButton(
                onPressed: () {
                  if (!c.formKeys.currentState!.validate()) {
                    return;
                  }

                  c.login();
                },
                text: 'Masuk',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
