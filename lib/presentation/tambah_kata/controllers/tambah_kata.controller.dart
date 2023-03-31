import 'dart:io';
import 'package:admin_kamus_sahu/infrastructure/navigation/routes.dart';
import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahKataController extends GetxController {
  File? _audioFile;
  RxBool isSelected = false.obs;
  final progress = RxDouble(0.0);
  void updateProgress(TaskSnapshot snapshot) {
    progress.value = snapshot.bytesTransferred / snapshot.totalBytes;
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'ogg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();
      const maxSize = 5 * 1024 * 1024; // maksimum ukuran file 2MB
      if (fileSize > maxSize) {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Ukuran file tidak boleh lebih dari 5MB',
          backgroundColor: oldRose,
          colorText: white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(0),
          borderRadius: 0,
          duration: const Duration(seconds: 4),
          animationDuration: const Duration(milliseconds: 600),
          reverseAnimationCurve: Curves.easeInBack,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          showProgressIndicator: false,
          overlayBlur: 0.0,
          overlayColor: darkBlue,
          icon: const Icon(
            EvaIcons.alertCircleOutline,
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
  Future<void> uploadAudioToFirebase() async {
    // Pastikan ada file audio yang dipilih
    if (_audioFile == null) {
      Get.snackbar('Error', 'Pilih file audio terlebih dahulu');
      return;
    }

    // Pastikan ada koneksi internet
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('Error', 'Tidak ada koneksi internet');
      return;
    }

    // Ambil referensi ke Firebase Storage dan Firestore
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('audio/${DateTime.now().toString()}');
    final firestoreRef = FirebaseFirestore.instance.collection('kamus').doc();

    try {
      // Tampilkan dialog progress dan progress bar
      showDialog(
        context: Get.overlayContext!,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              // Tampilkan pesan bahwa proses upload sedang berjalan
              Get.snackbar('Info', 'Proses upload sedang berjalan...');
              return false;
            },
            child: AlertDialog(
              title: Text('Mengunggah audio'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => LinearProgressIndicator(
                      value: progress
                          .value)), // Ubah progress menjadi sebuah variabel Rx agar dapat diupdate secara reactive
                  SizedBox(height: 16),
                  Obx(() => Text(
                      '${(progress * 100).toStringAsFixed(0)}%')), // Ubah progress menjadi sebuah variabel Rx agar dapat diupdate secara reactive
                ],
              ),
            ),
          );
        },
      );

      // Upload file audio ke Firebase Storage dan update progress bar
      final task = storageRef.putFile(_audioFile!);
      task.snapshotEvents.listen((snapshot) {
        updateProgress(
            snapshot); // Panggil fungsi updateProgress untuk mengubah nilai variabel progress
      });

      // Tunggu proses upload selesai
      await task;

      // Simpan URL file audio di Firestore
      final downloadUrl = await storageRef.getDownloadURL();
      await firestoreRef.set({'audioUrl': downloadUrl});

      // Reset file audio
      resetAudio();

      // Tampilkan pesan sukses
      Get.snackbar('Berhasil', 'File audio berhasil diunggah ke Firebase');
    } on FirebaseException catch (e) {
      // Tampilkan pesan kesalahan
      Get.snackbar(
          'Error', e.message ?? 'Terjadi kesalahan saat mengunggah file audio');
    } finally {
      // Tutup dialog progress
      Navigator.of(Get.overlayContext!).pop();

      // Cek apakah progress sudah 100%
      if (progress == 1.0) {
        // Ubah progress menjadi sebuah variabel Rx agar dapat diupdate secara reactive
        // Kembali ke halaman utama setelah proses upload selesai
        Future.delayed(
            Duration(seconds: 1), () => Get.offAllNamed(Routes.home));
      }
    }
  }
}
