import 'package:datingapp/tabSceens/user_detail_screen.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationSystem{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future whenNotificationsReceived(BuildContext context) async{
    //Quand l'app est fermeée et ouvert depuis la notification push
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage){
      if(remoteMessage != null){
        //ouverture app et visualisation des data de la notification
        openAppAndShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context
        );
      }
    });

    //Quand l'app est ouvert et user recoit une notifcation(foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage){
      if(remoteMessage != null){
        //ouverture app et visualisation des data de la notification
        openAppAndShowNotificationData(
            remoteMessage.data["userID"],
            remoteMessage.data["senderID"],
            context
        );
      }
    });

    //Quand l'app est en background et est ouvert directement a partir de la notif
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage){
      if(remoteMessage != null){
        //ouverture app et visualisation des data de la notification
        openAppAndShowNotificationData(
            remoteMessage.data["userID"],
            remoteMessage.data["senderID"],
            context
        );
      }
    });


  }

  openAppAndShowNotificationData(receivedID , senderID , context) async{
    await FirebaseServices.firestore
        .collection("users")
        .doc(senderID)
        .get()
        .then((snapshot){
          String profileImage = snapshot.data()!["imageUrl"].toString();
          String name = snapshot.data()!['fullname'].toString();
          String age = snapshot.data()!['age'].toString();
          String city = snapshot.data()!['city'].toString();
          String country = snapshot.data()!['country'].toString();
          String profession = snapshot.data()!['profession'].toString();
          
          showDialog(
              context: context,
              builder: (context){
                return notificationDialogBox(
                  senderID,
                  profileImage,
                  name,
                  age,
                  city,
                  country,
                  profession,
                  context

                );
              }
          );
      });
  }
  notificationDialogBox(senderId , profileImage,name,age,city, country, profession , context){
    return Dialog(
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: SizedBox(
            height: 300,
            child: Card(
              color: Colors.blueAccent.shade400,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(profileImage),
                  ),

                ),
                child:Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$name ● ${age.toString()}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8,),

                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,color: Colors.black87,size: 16,),
                            const SizedBox(height: 3,),
                            Expanded(
                              child: Text(
                                  "$city ● ${country.toString()}",
                                  style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )

                          ],
                        ),

                        const Spacer(),
                        Row(
                          children: [
                            Center(
                              child: ElevatedButton(
                                  onPressed:(){
                                    Get.back();

                                    Get.to(UserDetailScreen(userId: senderId));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF123880),
                                  ),
                                  child: const Text(
                                    "Voir profil"
                                  ),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed:(){
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFE63C5A),
                                ),
                                child: const Text(
                                    "Fermé"
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ) ,

              ),
            ),
          ),
        ),
      ),
    );
  }

  Future generateDeviceRegistrationToken() async{
    String? deviceToken = await messaging.getToken();
    
    FirebaseServices
        .firestore
        .collection("users")
        .doc(FirebaseServices.userCurrentId)
        .update({
          "userDeviceToken":deviceToken
        });
  }
}