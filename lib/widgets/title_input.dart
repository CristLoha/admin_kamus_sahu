import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class TittleInput extends StatelessWidget {
  final String text;
  const TittleInput({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: darkBlueTextStyle.copyWith(fontWeight: medium),
    );
  }
}
