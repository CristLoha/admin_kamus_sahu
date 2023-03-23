import 'package:flutter/material.dart';

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
          ),
        ),
      ],
    );
  }
}
