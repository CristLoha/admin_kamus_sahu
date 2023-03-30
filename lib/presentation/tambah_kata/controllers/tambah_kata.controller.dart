import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahKataController extends GetxController {
  File? _audioFile;
  RxBool isSelected = false.obs;
  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'ogg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();
      const maxSize = 2 * 1024 * 1024; // maksimum ukuran file 2MB
      if (fileSize > maxSize) {
        Get.snackbar('Error', 'File size cannot be larger than 2MB');
        return;
      }

      _audioFile = file;
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
