import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/person.dart';
import '../utils/globa_var.dart';
import '../utils/server.dart';

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  String userConnected = FirebaseServices.userCurrentId;
  var isProcessing = false.obs;

  getResults(){
    onInit();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(chosenAge == null || chosenCountry == null || chosenGender == null  ){
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
    }else{
      usersProfileList.bindStream(
          FirebaseServices.firestore.collection("users")
              .where("gender", isEqualTo: chosenGender.toString())
              .where("age", isGreaterThanOrEqualTo: int.parse(chosenAge.toString()))
              .where("country", isNotEqualTo: chosenCountry.toString())
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
        
        sendNotificationToUser(userId, "Favoris", senderName );
      }

      update();
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
        sendNotificationToUser(userId, "Like", senderName);
      }
      update();
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
        sendNotificationToUser(userId, "Vues", senderName);
      }
      update();
      return isAdding;

    } catch(error){
      Get.snackbar("Erreur", "Une erreur s'est produite : ${error.toString()}");
      rethrow;
    } finally{
      isProcessing(false);
    }


  }
/*
  sendNotificationToUser(receiverID, featureType, senderName)async{
    String deviceToken = "";

    FirebaseServices
        .firestore
        .collection("users")
        .doc(receiverID)
        .get()
        .then((snapshot){
        if(snapshot.data()!["userDeviceToken"] != null)
        {
          deviceToken = snapshot.data()!["userDeviceToken"].toString();
        }
    });
    notifcationFormat(deviceToken, receiverID, featureType, senderName);

  }

  notifcationFormat(deviceToken, receiverID, featureType, senderName){

    Map<String,String> headerNotifications = {
      "content-type":"application/json",
      "Authorization":fcmServerToken
    };

    Map bodyNotification = {
      "body":"Tu as recu un nouveau $featureType de la part de $senderName. Clique pour voir ",
      "title": "Nouveau $featureType",
    };

    Map dataMap={
      "click_action":"FLUTTER_NOTIFICATION_ACTION",
      "id":"1",
      "status":"Terminé",
      "userID": receiverID,
      "senderID": FirebaseServices.userCurrentId
    };

    Map notificationOfficialFormat={
      "notification":bodyNotification,
      "data":dataMap,
      'priority':"high",
      "to":deviceToken
    };
    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotifications,
      body:jsonEncode(notificationOfficialFormat)
    );
  }*/

Future<void> sendNotificationToUser(receiverID , featureType, senderName )async{
  try{
    final userDoc = await FirebaseServices.firestore
        .collection("users")
        .doc(receiverID)
        .get();
    final deviceToken = userDoc.data()!["userDeviceToken"].toString();
    if(deviceToken.isEmpty) return;

    final accessToken = await ServiceAccountHelper.getAccessToken();

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/datingapp-b6b68/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken.data}',
      },
      body: jsonEncode({
        'message': {
          'token': deviceToken,
          'notification': {
            'title': 'Nouveau $featureType',
            'body': 'Tu as reçu un nouveau $featureType de la part de $senderName. Clique pour voir',
          },
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_ACTION',
            'id': '1',
            'status': 'Terminé',
            'userID': receiverID,
            'senderID': FirebaseServices.userCurrentId,
          },
          'android': {
            'priority': 'HIGH',
          },
          'apns': {
            'headers': {
              'apns-priority': '10',
            },
          },
        },
      }),
    );
    if (response.statusCode != 200) {
      Get.snackbar("error","Failed to send notification:${response.body}");
    }
  }
  catch(e){
    Get.snackbar("error", "Error sending notification: $e");

  }
}




}