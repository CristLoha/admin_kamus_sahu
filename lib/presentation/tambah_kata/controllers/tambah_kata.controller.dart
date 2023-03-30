import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKataController extends GetxController {
  File? _audioFile;
  RxBool isSelected = false.obs;
  bool isUploading = false;

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

  Future<void> uploadAudio() async {
    if (_audioFile == null) {
      Get.snackbar('Error', 'Audio belum dipilih!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isUploading = true;
    update();

    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('audios').child(audioFileName);
      UploadTask uploadTask = ref.putFile(_audioFile!);
      TaskSnapshot taskSnapshot = await uploadTask;

      String audioUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('kamus').add({
        'audio_url': audioUrl,
        'audio_name': audioFileName,
        'audio_size': audioFileSize,
      });

      isUploading = false;
      resetAudio();
      Get.snackbar('Sukses', 'Audio berhasil diunggah!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseException catch (e) {
      isUploading = false;
      update();
      Get.snackbar('Error', e.message!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
