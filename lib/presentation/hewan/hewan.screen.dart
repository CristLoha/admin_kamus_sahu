import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/hewan.controller.dart';

class HewanScreen extends GetView<HewanController> {
  const HewanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HewanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HewanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
