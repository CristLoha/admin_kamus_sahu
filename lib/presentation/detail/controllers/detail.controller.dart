import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  Rx<DocumentSnapshot<Map<String, dynamic>>?> hewanDetail =
      Rx<DocumentSnapshot<Map<String, dynamic>>?>(null);

  Future<void> getHewanDetail(String id) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('kamus').doc(id).get();
      if (doc.exists) {
        hewanDetail.value = doc;
      } else {
        hewanDetail.value = null;
      }
    } catch (e) {
      print('Error while getting hewan detail: $e');
      hewanDetail.value = null;
    }
  }
}
