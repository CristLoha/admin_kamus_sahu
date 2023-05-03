import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../domain/models/aho_corasick_m.dart';

class AhoCorasickController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late AhoCorasick ahoC;

  // Inisialisasi Aho Corasick dengan daftar kata
  void init(List<String> patterns) {
    ahoC = AhoCorasick();
    ahoC.build(patterns);
  }

  // Mencari kata dalam teks menggunakan Aho Corasick
  List<int> search(String searchText) {
    List<int> results = ahoC.search(searchText.toLowerCase());
    return results;
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
