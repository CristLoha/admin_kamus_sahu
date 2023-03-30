import 'dart:io';
import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
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
        Get.snackbar(
          'Terjadi Kesalahan',
          'Ukuran file tidak boleh lebih dari 2MB',
          backgroundColor: oldRose,
          colorText: white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(0),
          borderRadius: 0,
          duration: const Duration(seconds: 4),
          animationDuration: const Duration(milliseconds: 500),
          reverseAnimationCurve: Curves.easeInBack,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          showProgressIndicator: false,
          overlayBlur: 0.0,
          overlayColor: darkBlue,
          icon: const Icon(
            Icons.error_outline,
            color: white,
          ),
          shouldIconPulse: true,
          leftBarIndicatorColor: oldRose,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          snackStyle: SnackStyle.FLOATING,
          messageText: Text(
            'Ukuran file tidak boleh lebih dari 2MB',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 13),
          ),
          titleText: Text(
            'Terjadi Kesalahan',
            style: whiteTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
        );

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
