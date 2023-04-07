import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/aho_corasick_m.dart';

class AhoCorasickController extends GetxController {
  final CollectionReference _kamusCollection =
      FirebaseFirestore.instance.collection('kamus');
  late AhoCorasick _ac;
  TextEditingController pencarian = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    _loadKamus();
  }

  Future<void> _loadKamus() async {
    QuerySnapshot querySnapshot = await _kamusCollection.get();
    List<String> words =
        querySnapshot.docs.map((doc) => doc.get('kataSahu') as String).toList();
    _ac.build(words);
  }

  List<int> search(String text) {
    Stopwatch stopwatch = Stopwatch()..start();
    List<int> results = _ac.search(text);
    stopwatch.stop();

    if (results.isNotEmpty) {
      Get.snackbar(
        'Hasil Pencarian',
        'Kata ditemukan dalam waktu ${stopwatch.elapsedMilliseconds} ms',
        duration: const Duration(seconds: 3),
      );
    }

    return results;
  }
}
