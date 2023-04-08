import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../domain/models/kamus.dart';

class KamusController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Kamus> kamusList = RxList<Kamus>([]);

  void searchKamus(String keyword) async {
    kamusList.value = [];

    var kamusRef = firestore.collection('kamus');

    var querySnapshot = await kamusRef
        .orderBy('kataSahu')
        .startAt([keyword.toLowerCase()]).endAt(
            ['${keyword.toLowerCase()}\uf8ff']).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        var kamus = Kamus.fromJson(doc.data());
        if (kamus.kataSahu?.toLowerCase() == keyword.toLowerCase()) {
          kamusList.add(kamus);
        }
      }
    }
  }
}
