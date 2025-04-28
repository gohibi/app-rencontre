import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:get/get.dart';

import '../models/person.dart';

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  String userConnected = FirebaseServices.userCurrentId;
  var isProcessing = false.obs;

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

  Future<bool> favoriteSentAndFavoriteReceived(String userId , String senderName) async{
    try{
      var document = await FirebaseServices.firestore
          .collection("users")
          .doc(userId)
          .collection("favoriteReceived").doc(userConnected)
          .get();

      bool isAdding = !document.exists;
      //efface le favorite dans la database
      if(document.exists){
        //efface l'user connecté de la collection favoriteReceived de le profil personne sur laquelle il a mis en favori
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("favoriteReceived").doc(userConnected)
            .delete();

        //efface profile en favori de la collection favoriteSent de l'utilisateur connecté
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("favoriteSent").doc(userId)
            .delete();
      } //add favori dans la base ( marquer en favori)
      else {
        // ajouter [userConnected] a la collection favoriteReceived le profil de la personne en favori [userId]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("favoriteReceived").doc(userConnected)
            .set({});

        // ajouter le profil [userId] a la collection favoriteSent a l'utilisateur [userConnected]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("favoriteSent").doc(userId)
            .set({});
      }
      return isAdding;

    } catch(error){
      Get.snackbar("Erreur", "Une erreur s'est produite : ${error.toString()}");
      rethrow;
    } finally{
      isProcessing(false);
    }


  }

  Future<bool> likeSentAndLikeReceived(String userId , String senderName) async{
    try{
      var document = await FirebaseServices.firestore
          .collection("users")
          .doc(userId)
          .collection("likeReceived").doc(userConnected)
          .get();

      bool isAdding = !document.exists;
      //efface le favorite dans la database
      if(document.exists){
        //efface l'user connecté de la collection favoriteReceived de le profil personne sur laquelle il a mis en favori
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("likeReceived").doc(userConnected)
            .delete();

        //efface profile en favori de la collection favoriteSent de l'utilisateur connecté
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("likeSent").doc(userId)
            .delete();
      } //add favori dans la base ( marquer en favori)
      else {
        // ajouter [userConnected] a la collection favoriteReceived le profil de la personne en favori [userId]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("likeReceived").doc(userConnected)
            .set({});

        // ajouter le profil [userId] a la collection favoriteSent a l'utilisateur [userConnected]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("likeSent").doc(userId)
            .set({});
      }
      return isAdding;

    } catch(error){
      Get.snackbar("Erreur", "Une erreur s'est produite : ${error.toString()}");
      rethrow;
    } finally{
      isProcessing(false);
    }


  }

  Future<bool> viewSentAndViewReceived(String userId , String senderName) async{
    try{
      var document = await FirebaseServices.firestore
          .collection("users")
          .doc(userId)
          .collection("viewReceived").doc(userConnected)
          .get();

      bool isAdding = !document.exists;
      //efface le favorite dans la database
      if(document.exists){
        //efface l'user connecté de la collection favoriteReceived de le profil personne sur laquelle il a mis en favori
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("viewReceived").doc(userConnected)
            .delete();

        //efface profile en favori de la collection favoriteSent de l'utilisateur connecté
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("viewSent").doc(userId)
            .delete();
      } //add favori dans la base ( marquer en favori)
      else {
        // ajouter [userConnected] a la collection favoriteReceived le profil de la personne en favori [userId]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userId)
            .collection("viewReceived").doc(userConnected)
            .set({});

        // ajouter le profil [userId] a la collection favoriteSent a l'utilisateur [userConnected]
        await FirebaseServices.firestore
            .collection("users")
            .doc(userConnected)
            .collection("viewSent").doc(userId)
            .set({});
      }
      return isAdding;

    } catch(error){
      Get.snackbar("Erreur", "Une erreur s'est produite : ${error.toString()}");
      rethrow;
    } finally{
      isProcessing(false);
    }


  }




}