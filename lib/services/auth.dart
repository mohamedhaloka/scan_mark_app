import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Auth{
  
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  
  signInWithEmailAndPassword(email,pass)async
  {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
  }
}