import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:admin_kamus_sahu/presentation/splash_screen/components/splash_logo.dart';
import 'package:admin_kamus_sahu/utils/extension/box_extension.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/form_login.dart';
import 'components/header_login.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          100.heightBox,
          const HeaderLogin(),
          85.heightBox,
          const FormLogin(),
        ],
      ),
    );
  }
}
