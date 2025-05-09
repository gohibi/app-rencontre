import 'dart:io';

import 'package:datingapp/controllers/profile_controller.dart';

import 'package:datingapp/utils/error.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/globa_var.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {

  final ProfileController profileController = Get.find<ProfileController>();

  String senderName = "";


  readCurrentUserdata() async {
    await FirebaseServices.firestore
        .collection("users")
        .doc(FirebaseServices.userCurrentId)
        .get()
        .then((snapshot) {
      setState(() {
        senderName = snapshot.data()!["fullname"].toString();
      });
    });
  }

  applyFilter(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return AlertDialog(
                  title: const Text("Flitre"),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Je recherche"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                          hint: const Text("Selectionne le genre"),
                            value: chosenGender,
                            underline: Container(),
                            items: [
                              "Homme",
                              "Femme"
                            ].map((value){
                              return DropdownMenuItem<String>(
                                value:value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  )
                              );
                            }).toList(),
                            onChanged: (String? value){
                              setState(() {
                                chosenGender = value;
                              });
                            }
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const Text("Qui vit "),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                            hint: const Text("Selectionne un pays"),
                            value: chosenCountry,
                            underline: Container(),
                            items: [
                              "Cote d'ivoire",
                              "Cameroun",
                              "Ghana",
                              "France",
                              "Russie",
                              "Canada",
                              "Burkina Faso",
                              "Congo"
                            ].map((value){
                              return DropdownMenuItem<String>(
                                  value:value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  )
                              );
                            }).toList(),
                            onChanged: (String? value){
                              setState(() {
                                chosenCountry = value;
                              });
                            }
                        ),
                      ),
                      const SizedBox(height: 20,),


                      const Text("Dont l'âge est égal ou supérieur à "),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                            hint: const Text("Selectionne l'age"),
                            value: chosenAge,
                            underline: Container(),
                            items: [
                              "18",
                              "20",
                              "22",
                              "24",
                              "25",
                              "27",
                              "30",
                              "32",
                              "35"
                            ].map((value){
                              return DropdownMenuItem<String>(
                                  value:value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  )
                              );
                            }).toList(),
                            onChanged: (String? value){
                              setState(() {
                                chosenAge = value;
                              });
                            }
                        ),
                      ),
                      const SizedBox(height: 20,),

                    ],

                  ),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Get.back();
                      profileController.getResults();

                    }, child: const Text("Terminé"))
                  ],
                );
              }
          );
        }
    );
  }

  startChattingInWhatsApp(String receiverPhoneNumber) async{
    String text = '';
    var androidUrl = "whatsapp://send?phone=$receiverPhoneNumber&text=$text";
    var iosUrl = "https://wa.me/$receiverPhoneNumber?text=${Uri.parse(text)}";
    try{
        if(Platform.isIOS){
          await launchUrl((Uri.parse(iosUrl)));
        }
        else{
          await launchUrl((Uri.parse(androidUrl)));
        }
    }
    on Exception{
      showDialog(
          context: context,
          builder: (BuildContext context)
          {
            return AlertDialog(
              title: const Text("WhatsApp introuvable"),
              content: const Text("WhatsApp n'est pas installé"),
              actions: [
                TextButton(
                    onPressed: (){Get.back();},
                    child: const Text("OK")
                )
              ],
            );
          }
      );
    }
    catch(error){

    }
  }

  @override
  void initState() {
    super.initState();
    readCurrentUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          return PageView.builder(
            itemCount: profileController.allUsersProfileList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final infoProfileUser = profileController.allUsersProfileList[index];
              return GestureDetector(
                onTap:  profileController.isProcessing.value
                    ? null
                    : () async {
                  try{
                    final isAdded = await profileController.viewSentAndViewReceived(infoProfileUser.uid.toString(), senderName);
                    _showCustomDialog(isAdded, "Ce profil a été ajouté dans les vues", "Ce profil a été retiré des vues");
                  } catch(e){
                    showCustomizeDialog(context: context, title: "Erreur", content: "Opération échouée : ${e.toString()}");
                  }
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(infoProfileUser.imageUrl.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: IconButton(
                                onPressed: () {
                                  applyFilter();
                                },
                                icon: Icon(
                                  Icons.filter_list_outlined,
                                  size: 32,
                                  color: Color(0xFF123880),
                                )
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap:(){},
                          child: Column(
                            children: [
                              //afficher le nom
                              Text(
                                infoProfileUser.fullname.toString().toUpperCase(),
                                style: TextStyle(
                                  color: Color(0xFF123880),
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                ),

                              ),

                              //Afficher age et ville de user
                              Text(
                                  "${infoProfileUser.age
                                      .toString()} ans ● ${infoProfileUser.city
                                      .toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3,
                                  )
                              ),

                              const SizedBox(height: 5,),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white60,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(15)
                                            )
                                        ),
                                        child: Text(
                                          infoProfileUser.profession.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                        )
                                    ),
                                    const SizedBox(width: 10,),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white60,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(15)
                                            )
                                        ),
                                        child: Text(
                                          infoProfileUser.relationshipYouLookingFor.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                        )
                                    ),
                                    const SizedBox(width: 10,),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white60,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(15)
                                            )
                                        ),
                                        child: Text(
                                          infoProfileUser.country.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              )

                            ],


                          ),
                        ),
                        const SizedBox(height: 20,),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  startChattingInWhatsApp(infoProfileUser.phone.toString());
                                },
                                child: Image.asset(
                                  "images/chat_104913.png",
                                  width: 60,
                                ),
                              ),
                              GestureDetector(
                                onTap: profileController.isProcessing.value
                                ? null
                                : () async {
                                  try{
                                    final isAdded = await profileController.likeSentAndLikeReceived(infoProfileUser.uid.toString(), senderName);
                                    _showCustomDialog(isAdded,"Ce profil est maintenant dans vos likes","Ce profil a été retiré de vos likes");

                                  }
                                  catch(e){
                                    showCustomizeDialog(context: context, title:"Erreur", content: "Opération échouée : ${e.toString()}");
                                  }
                                },
                                child: Image.asset(
                                  "images/facebook_like_thumbs_up_icon_181634.png",
                                  width: 60,
                                ),
                              ),

                              GestureDetector(
                                onTap: profileController.isProcessing.value
                                ?null
                                : ()async{
                                  try{
                                    final isAdded = await profileController.favoriteSentAndFavoriteReceived(
                                        infoProfileUser.uid.toString(),
                                        senderName
                                    );
                                   /* Get.dialog(
                                      AlertDialog(
                                        title: Text(isAdded ? "Ajout réussi" : "Suppression réussie"),
                                        content: Text(
                                            isAdded
                                                ? "Ce profil a été ajouté à vos favoris !"
                                                : "Ce profil a été retiré de vos favoris."
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text("OK"),
                                          ),
                                        ],
                                      ),
                                      barrierDismissible: false
                                    );*/
                                    _showCustomDialog(isAdded,"Ce profil est maintenant dans vos favoris","Ce profil a été retiré de vos favoris");

                                  }
                                  catch(e){
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text("Erreur"),
                                        content: Text("Opération échouée : ${e.toString()}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text("OK"),
                                          ),
                                        ],
                                      )
                                    );
                                  }
                              },
                                child: Opacity(
                                  opacity: profileController.isProcessing.value ? 0.5 : 1,
                                  child: Image.asset(
                                    "images/favorite_star.png",
                                    width: 60,
                                  ),
                                ),

                              ),
                              if (profileController.isProcessing.value)
                                CircularProgressIndicator(),
                            ],

                          );
                        }),


                      ],
                    ),
                  ),
                ),
              );
            },
          );
        })
    );
  }
}
void _showCustomDialog(bool isAdded,String text1 , String text2) {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white, // Couleur de fond
      insetPadding: EdgeInsets.all(20), // Marge externe
      contentPadding: EdgeInsets.all(20), // Marge interne
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: SizedBox(
        width: 300, // Largeur fixe
        height: 250, // Hauteur fixe
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icône
            Icon(
              isAdded ? Icons.favorite : Icons.favorite_border,
              size: 60,
              color: Color(0xFF123880),
            ),

            // Titre
            Text(
              isAdded ? "Ajouté !" : "Retiré !",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            //"Ce profil est maintenant dans vos favoris"
            //"Ce profil a été retiré de vos favoris"
            // Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                isAdded
                    ? text1
                    : text2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),

            // Bouton
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF123880),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Get.back(),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
