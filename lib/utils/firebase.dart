import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/authentication_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseServices{
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String userCurrentId = auth.currentUser!.uid;

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password
  })async{
  return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }


  Future<UserCredential> signInUserWithEmailAndPassword({
    required String email,
    required String password
  })async{
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void>sigOut() async{
    await auth.signOut();
    Get.to(LoginScreen());
  }

}
