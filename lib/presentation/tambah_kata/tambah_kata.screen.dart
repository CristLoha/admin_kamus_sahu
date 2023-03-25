import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tambah_kata.controller.dart';

class TambahKataScreen extends GetView<TambahKataController> {
  const TambahKataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TambahKataScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahKataScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
