import 'dart:async';

import 'package:admin_kamus_sahu/infrastructure/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../../../app/controller/aho_corasick.dart';
import '../../../domain/models/filter_snapshot.dart';

class HewanController extends GetxController {
  final AhoCorasickController _ahoC = Get.put(AhoCorasickController());
  final searchText = ''.obs;
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

  Stream<FilteredQuerySnapshot<Map<String, dynamic>>> getHewan() {
    CollectionReference layanan = firestore.collection('kamus');
    Stream<QuerySnapshot> stream =
        layanan.where('kategori', isEqualTo: 'Hewan').snapshots();

    // Konversi searchText menjadi Stream
    Stream<String> searchTextStream = searchText.subject.stream.startWith('');

    Stream<FilteredQuerySnapshot<Map<String, dynamic>>> transformedStream =
        rxdart.Rx.combineLatest2<QuerySnapshot, String,
            FilteredQuerySnapshot<Map<String, dynamic>>>(
      stream,
      searchTextStream,
      (QuerySnapshot snapshot, String searchText) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDataList =
            filterDataListUsingAhoCorasick(
                snapshot.docs
                    .cast<QueryDocumentSnapshot<Map<String, dynamic>>>(),
                searchText);
        return FilteredQuerySnapshot(filteredDataList, snapshot.metadata);
      },
    );

    return transformedStream;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>>
      filterDataListUsingAhoCorasick(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList,
          String searchText) {
    if (searchText.isEmpty) {
      return dataList;
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDataList = [];
    for (var data in dataList) {
      String keyword = isSahu.value
          ? (data.data()['kataSahu'] ?? '')
          : (data.data()['kataIndonesia'] ?? '');
      if (_ahoC.search(keyword, searchText)) {
        filteredDataList.add(data);
      }
    }

    return filteredDataList;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterDataList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList,
      String searchText) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDataList = [];

    if (searchText.isEmpty) {
      return dataList;
    }

    for (var data in dataList) {
      String keyword = isSahu.value
          ? (data.data()['kataSahu'] ?? '')
          : (data.data()['kataIndonesia'] ?? '');

      if (keyword.toLowerCase().contains(searchText.toLowerCase())) {
        filteredDataList.add(data);
      }
    }

    return filteredDataList;
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
