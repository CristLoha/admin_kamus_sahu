import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HewanController extends GetxController {
  var isSahu = true.obs; // initial language is Sahu

  void toggleLanguage() {
    isSahu.value = !isSahu.value; // toggle the language
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
}
