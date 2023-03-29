import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahKataController extends GetxController {
  File? _audioFile;
  RxBool isSelected = false.obs;

  Future<void> pickAudio() async {
    if (_audioFile != null) {
      bool confirmReset = await Get.dialog<bool>(
            AlertDialog(
              title: Text('Reset audio?'),
              content: Text(
                  'Anda akan mengganti audio yang sudah dipilih sebelumnya. Anda yakin ingin melanjutkan?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: Text('Reset'),
                ),
              ],
            ),
          ) ??
          false;

      if (!confirmReset) return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'ogg'],
    );

    if (result != null) {
      _audioFile = File(result.files.single.path!);
      isSelected.value = true;
      update();
    }
  }

  void resetAudio() {
    _audioFile = null;
    isSelected.value = false;
    update();
  }

  String get audioFileName =>
      _audioFile != null ? _audioFile!.path.split('/').last : '';

  String get audioFileSize => _audioFile != null
      ? '${(_audioFile!.lengthSync() / 1024).toStringAsFixed(2)} KB'
      : '';
}
