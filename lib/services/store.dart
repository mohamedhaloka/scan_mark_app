import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_mark_app/const.dart';

class Store {
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;

  storeUserInfo(data,id) async {
    await firebaseFirestore.collection(kUserCollection).doc(id).set(data);
  }

  getUserInfo(data) async {
    await firebaseFirestore.collection(kUserCollection).doc().set(data);
  }

}
