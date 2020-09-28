import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signInWithEmailAndPassword(email, pass) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  signUpWithEmailAndPassword(email, pass) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
  }

  signOut() {
    return firebaseAuth..signOut();
  }
}
