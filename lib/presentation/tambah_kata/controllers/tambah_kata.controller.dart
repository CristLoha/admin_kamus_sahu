import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TambahKataController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> uploadAudio(File audioFile) async {
    try {
      _isLoading.value = true;

      // Validasi jenis file audio yang diunggah
      if (audioFile.path.endsWith('.mp3') || audioFile.path.endsWith('.wav')) {
        // Membuat referensi ke Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('audioPria')
            .child('${DateTime.now().millisecondsSinceEpoch}.mp3');

        // Upload file audio ke Firebase Storage
        final uploadTask = ref.putFile(audioFile);
        await uploadTask.whenComplete(() {});

        // Mendapatkan URL file yang diupload
        final url = await ref.getDownloadURL();

        // Menyimpan URL file ke Firestore
        final docRef = FirebaseFirestore.instance.collection('audioPria').doc();
        await docRef.set({'url': url});

        Get.snackbar('Berhasil Mengunggah', 'Audio berhasil diunggah!');
      } else {
        throw 'Jenis file audio tidak didukung';
      }
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar('Gagal Upload', 'Gagal mengupload audio: $e');
    }
  }
}
