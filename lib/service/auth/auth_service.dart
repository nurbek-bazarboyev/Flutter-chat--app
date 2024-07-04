import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  // get instance of firebase auth and firestore
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in
  Future<void> signINwithemailandpassword(String email,password)async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  // sign up
  Future<void> signUPwithemailandpassword(String email,password,name)async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':email,
        'name':name,
      });
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> singOut()async{
    await _firebaseAuth.signOut();
  }
}