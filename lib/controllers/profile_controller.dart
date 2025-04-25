import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:get/get.dart';

import '../models/person.dart';

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    usersProfileList.bindStream(
      FirebaseServices.firestore.collection("users")
          .where("uid", isNotEqualTo: FirebaseServices.auth.currentUser!.uid)
          .snapshots()
          .map((QuerySnapshot querySnapshotData){
            List<Person> allUsers = [];
            for( var eachUser in querySnapshotData.docs){
              allUsers.add(Person.fromDataSnapshot(eachUser));
            }
            return allUsers;
      })
          
    );
  }
}