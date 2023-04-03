import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LanguageController extends GetxController {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('kamus');
}
