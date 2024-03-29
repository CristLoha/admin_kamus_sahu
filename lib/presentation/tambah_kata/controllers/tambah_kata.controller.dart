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
  final GlobalKey<FormState> formKe1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final progress = RxDouble(0.0);
  File? _audioFilePria;
  RxBool isSelectedPria = false.obs;

  File? _audioFileWanita;
  RxBool isSelectedWanita = false.obs;

  var errorText = ''.obs;

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

  void onOptionChanged(String? newValue) {
    if (newValue != null) {
      selectedOption.value = newValue;
      errorText.value =
          ''; // Menghilangkan pesan kesalahan saat kategori dipilih
    } else {
      errorText.value = 'Pilih salah satu opsi';
    }
  }

  void handleSubmit() {
    if (selectedOption.value.isEmpty) {
      // Jika dropdown belum dipilih, tampilkan pesan error
      errorText.value = 'Pilih salah satu opsi';
    } else if (kategori.text.isEmpty) {
      // Jika teks field kosong, tampilkan pesan error
      errorText.value = 'Input tidak boleh kosong';
    } else {
      // Simpan nilai kategori ke dalam controller
      kategori.text = selectedOption.value;
      // Kirim data
      sendDataToFirebase();
    }
  }

  ///PRIA
  Future<void> pickAudioPria() async {
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

      _audioFilePria = file;
      isSelectedPria.value = true;

      update();
    }
  }

  void resetAudioPria() {
    _audioFilePria = null;
    isSelectedPria.value = false;
    update();
  }

  String get audioFileNamePria =>
      _audioFilePria != null ? _audioFilePria!.path.split('/').last : '';
  String get audioFileSizePria => _audioFilePria != null
      ? '${(_audioFilePria!.lengthSync() / 1024).toStringAsFixed(2)} KB'
      : '';

  ///PRIAwANITA
  Future<void> pickAudioWanita() async {
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

      _audioFileWanita = file;
      isSelectedWanita.value = true;

      update();
    }
  }

  void resetAudioWanita() {
    _audioFileWanita = null;
    isSelectedWanita.value = false;
    update();
  }

  String get audioFileNameWanita =>
      _audioFileWanita != null ? _audioFileWanita!.path.split('/').last : '';
  String get audioFileSizeWanita => _audioFileWanita != null
      ? '${(_audioFileWanita!.lengthSync() / 1024).toStringAsFixed(2)} KB'
      : '';

  Future<void> sendDataToFirebase() async {
    if (selectedOption.value.isEmpty || errorText.value.isNotEmpty) {
      // Tampilkan pesan error jika kategori belum dipilih atau ada pesan error pada dropdown
      errorText.value = 'Pilih salah satu kategori';
      return;
    }

    // Pastikan ada file audio yang dipilih

    ///pria
    if (_audioFilePria == null) {
      infoFailed("Terjadi kesalahan", "Pilih audio terlebih dahulu");
      return;
    }

    if (_audioFileWanita == null) {
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
    final storageRefPria = FirebaseStorage.instance
        .ref()
        .child('audioPria/${DateTime.now().toString()}');

    final storageRefWanita = FirebaseStorage.instance
        .ref()
        .child('audioWanita/${DateTime.now().toString()}');
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
                style: darkBlueTextStyle.copyWith(fontWeight: medium),
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
// Upload file audio untuk pria ke Firebase Storage dan update progress bar
      final taskpria = storageRefPria.putFile(_audioFilePria!);
      taskpria.snapshotEvents.listen((snapshot) {
        updateProgress(snapshot);
      });
      await taskpria;

// Upload file audio untuk wanita ke Firebase Storage dan update progress bar
      final taskWanita = storageRefWanita.putFile(_audioFileWanita!);
      taskWanita.snapshotEvents.listen((snapshot) {
        updateProgress(snapshot);
      });
      await taskWanita;

// Set metadata file audio menjadi "audio/mpeg"
      final metadata = SettableMetadata(contentType: 'audio/mpeg');
      await storageRefPria.updateMetadata(metadata);
      await storageRefWanita.updateMetadata(metadata);

      // Simpan URL file audio di Firestore
      final downloadUrlPria = await storageRefPria.getDownloadURL();
      final downloadUrlWanita = await storageRefPria.getDownloadURL();
      await firestoreRef.set({
        'audioUrlPria': downloadUrlPria,
        'audioUrlWanita': downloadUrlWanita,
        'kataSahu': kSahu.text,
        'contohKataSahu': cKSahu.text,
        'kataIndonesia': kIndo.text,
        'contohKataIndo': cKIndo.text,
        'kategori': selectedOption.value,
      }); // Tambahkan data kata Sahu dan Indonesia beserta URL audio ke Firestore

      // Reset file audio
      resetAudioPria();

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
        Future.delayed(const Duration(milliseconds: 1),
            () => Get.offAllNamed(Routes.home));
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
