import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scan_mark_app/const.dart';

class Store {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  storeUserInfo(data, id) async {
    await firebaseFirestore.collection(kUserCollection).doc(id).set(data);
  }


  storeCartOfUserInfo(data, id) async {
    await firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kCartCollection)
        .doc()
        .set(data);
  }

  storeFavouriteOfUser(data, id) async {
    await firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kFavouriteCollection)
        .doc()
        .set(data);
  }

  deleteCartOfUserInfo(id, postID) async {
    await firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kCartCollection)
        .doc(postID)
        .delete();
  }

  deleteFavouriteOfUserInfo(id, postID) async {
    await firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kFavouriteCollection)
        .doc(postID)
        .delete();
  }

  getUserInfo(data) async {
    await firebaseFirestore.collection(kUserCollection).doc().set(data);
  }

  Stream<QuerySnapshot> getProducts() {
    return firebaseFirestore.collection(kProductCollection).snapshots();
  }

  Stream<QuerySnapshot> getCartOfUser(id) {
    return firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kCartCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> getFavouriteOfUser(id) {
    return firebaseFirestore
        .collection(kUserCollection)
        .doc(id)
        .collection(kFavouriteCollection)
        .snapshots();
  }

  Stream<QuerySnapshot> getMarketsOfProudest(id) {
    return firebaseFirestore
        .collection(kProductCollection)
        .doc(id)
        .collection(kMarketsCollection)
        .snapshots();
  }
}
