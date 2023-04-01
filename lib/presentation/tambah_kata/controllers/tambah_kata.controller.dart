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
  RxString selectedOption = ''.obs;
  List<String> options = [
    'Hewan',
    'Benda',
    'Kerja',
    'Tumbuhan',
    'Tempat',
    'Angka',
    'Anggota Tubuh',
    'Sifat',
    'Depan',
  ];

  TextEditingController kSahu = TextEditingController();
  TextEditingController cKSahu = TextEditingController();
  TextEditingController kIndo = TextEditingController();
  TextEditingController cKIndo = TextEditingController();
  TextEditingController kategori = TextEditingController();

  void updateProgress(TaskSnapshot snapshot) {
    progress.value = snapshot.bytesTransferred / snapshot.totalBytes;
  }

  String get selectedValue => selectedOption.value;

  void onOptionChanged(String? value) {
    if (value != null) {
      selectedOption.value = value;
      kategori.text = value; // update nilai kategori dengan value yang dipilih
    }
  }

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'ogg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();
      const maxSize = 5 * 1024 * 1024; // maksimum ukuran file 5MB
      if (fileSize > maxSize) {
        infoFailed(
            "Terjadi kesalahan", "Ukuran file tidak boleh lebih dari 5MB");

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
  Future<void> sendDataToFirebase() async {
    // Pastikan ada file audio yang dipilih
    if (_audioFile == null) {
      infoFailed("Terjadi kesalahan", "Pilih audio terlebih dahulu");
      return;
    }

    // Pastikan ada koneksi internet
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      infoFailed(
          "Tidak ada Internet", "Silahkan periksa koneksi internet Anda");
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
              title: Text(
                'Sedang mengirim data...',
                style: darkBlueTextStyle.copyWith(fontSize: 12),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => LinearProgressIndicator(
                      value: progress
                          .value)), // Ubah progress menjadi sebuah variabel Rx agar dapat diupdate secara reactive
                  const SizedBox(height: 16),
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

      // Ubah tipe MIME file audio menjadi "audio/mpeg"
      final metadata = SettableMetadata(contentType: 'audio/mpeg');
      await storageRef.updateMetadata(metadata);

      // Simpan URL file audio di Firestore
      final downloadUrl = await storageRef.getDownloadURL();
      await firestoreRef.set({
        'audioUrl': downloadUrl,
        'kataSahu': kSahu.text,
        'contohKataSahu': cKSahu.text,
        'kataIndonesia': kIndo.text,
        'contohKataIndo': cKIndo.text,
        'kategori': kategori.text,
      }); // Tambahkan data kata Sahu dan Indonesia beserta URL audio ke Firestore

      // Reset file audio
      resetAudio();

      // Tampilkan pesan sukses
      infoSuccess("Berhasil", "Data berhasil terkirim");
    } on FirebaseException {
      // Tampilkan pesan kesalahan
      infoFailed("Gagal mengunggah file audio",
          "Terjadi Kesalahan saat menggungah file audio");
    } finally {
      // Tutup dialog progress
      Navigator.of(Get.overlayContext!).pop();
      // Cek apakah progress sudah 100%
      if (progress.value == 1.0) {
        // Ubah progress menjadi sebuah variabel Rx agar dapat diupdate secara reactive
        // Kembali ke halaman utama setelah proses upload selesai
        Future.delayed(
            const Duration(seconds: 1), () => Get.offAllNamed(Routes.home));
      }
    }
  }

  void infoFailed(String msg1, String msg2) {
    Get.snackbar(
      "",
      "",
      backgroundColor: oldRose,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM,
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
      titleText: Text(
        msg1,
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
      messageText: Text(
        msg2,
        style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 12),
      ),
    );
  }

  void infoSuccess(String msg1, String msg2) {
    Get.snackbar(
      "",
      "",
      backgroundColor: shamrockGreen,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(0),
      borderRadius: 0,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 600),
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      showProgressIndicator: false,
      overlayBlur: 0.0,
      overlayColor: white, // Menggunakan warna putih
      icon: const Icon(
        EvaIcons.checkmarkCircle2Outline,
        color: white,
      ),
      shouldIconPulse: true,
      leftBarIndicatorColor: shamrockGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        msg1,
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
      messageText: Text(
        msg2,
        style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 12),
      ),
    );
  }
}
