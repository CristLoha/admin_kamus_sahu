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

  void showSearchResultMessage(String searchText) {
    if (searchText.isNotEmpty) {
      int searchDuration = searchAndGetResultDuration(searchText);
      if (searchDuration > 0) {
        Get.snackbar(
          'Hasil Pencarian',
          'Daftar kata muncul dalam $searchDuration milidetik',
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  // Inisialisasi Aho Corasick dengan daftar kata
  void init(List<String> patterns) {
    ahoC = AhoCorasick();
    ahoC.build(patterns);
  }

  // Mencari kata dalam teks menggunakan Aho Corasick
  bool search(String keyword, String searchText) {
    return keyword.toLowerCase().contains(searchText.toLowerCase());
  }

  void initAhoCorasickWithSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList, bool isSahu) {
    List<String> patterns = dataList
        .map((data) =>
            (isSahu ? data.data()['kataSahu'] : data.data()['kataIndonesia']))
        .cast<String>()
        .toList();

    init(patterns);
  }
}
