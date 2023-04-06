import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HewanController extends GetxController {
  var isSahu = true.obs; // initial language is Sahu
  var selectedLanguage = 'Indonesia'.obs;

  void toggleLanguage() {
    isSahu.value = !isSahu.value; // toggle the language
    selectedLanguage.value =
        isSahu.value ? 'Sahu' : 'Indonesia'; // update selected language
  }

  void updateLanguage() {
    toggleLanguage();
    getHewan();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getHewan() {
    CollectionReference layanan = firestore.collection('kamus');
    return layanan.where('kategori', isEqualTo: 'Hewan').snapshots();
  }

  Future<void> deleteHewan(String id) async {
    CollectionReference kamus = firestore.collection('kamus');
    DocumentReference docRef = kamus.doc(id);

    // Tampilkan dialog konfirmasi sebelum menghapus item
    var confirmed = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Konfirmasi',
          style: darkBlueTextStyle.copyWith(fontWeight: bold),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus item ini?',
          style: darkBlueTextStyle.copyWith(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text(
              'Tidak',
              style: darkBlueTextStyle,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text(
              'Ya',
              style: oldRoseTextStyle,
            ),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await docRef.delete();
      Get.snackbar('Berhasil', 'Item telah dihapus',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
