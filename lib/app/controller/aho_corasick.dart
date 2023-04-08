import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../domain/models/aho_corasick_m.dart';

class AhoCorasickController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late AhoCorasick ahoC;

  Future<void> build() async {
    var kamusRef = firestore.collection('kamus');
    var querySnapshot = await kamusRef.get();

    List<String> patterns = [];
    for (var doc in querySnapshot.docs) {
      var kataSahu = doc.data()['kataSahu'];
      if (kataSahu is String) {
        patterns.add(kataSahu.toLowerCase());
      }
    }

    ahoC = AhoCorasick();
    ahoC.build(patterns);
  }

  int searchAndGetResultDuration(String keyword) {
    List<int> results = ahoC.search(keyword.toLowerCase());
    return results.length * 10; // misalnya 10 detik per hasil
  }

  void searchAndShowSnackbar(String keyword) {
    int resultDuration = searchAndGetResultDuration(keyword);
    if (resultDuration > 0) {
      Get.snackbar(
        'Kata ditemukan',
        'Kata "$keyword" ditemukan dalam $resultDuration detik',
        duration: const Duration(seconds: 3),
      );
    }
  }
}
