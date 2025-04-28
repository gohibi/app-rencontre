import 'package:datingapp/settings/account_settings_screen.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailScreen extends StatefulWidget {
 final String userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  String fullname="";
  int? age ;
  String phone="";
  String country="";
  String city="";
  String profileHeading="";
  String lookingForPartner="";
  String gender="";

  // Apparences
  String height="";
  String weight="";
  String bodyType="";

  // Lifestyle
  String drink="";
  String smoke="";
  String maritalStatus="";
  String haveChildren="";
  String noOfChildren="";
  String profession="";
  String employmentStatus="";
  String incoming="";
  String livingSituation="";
  String willingToRelocate="";
  String relationshipYouLookingFor="";
  // Background
  String nationality="";
  String ethnicity="";
  String education="";
  String religion="";
  String languageSpoken="";

  //imageUrl

  String imageUrl1="https://res.cloudinary.com/dcpvgjzbk/image/upload/v1745605967/cglu0scsozspc9zsjnm9.png";
  String imageUrl2="https://res.cloudinary.com/dcpvgjzbk/image/upload/v1745605967/cglu0scsozspc9zsjnm9.png";
  String imageUrl3="https://res.cloudinary.com/dcpvgjzbk/image/upload/v1745605967/cglu0scsozspc9zsjnm9.png";
  String imageUrl4="https://res.cloudinary.com/dcpvgjzbk/image/upload/v1745605967/cglu0scsozspc9zsjnm9.png";
  String imageUrl5="https://res.cloudinary.com/dcpvgjzbk/image/upload/v1745605967/cglu0scsozspc9zsjnm9.png";

  fetchDataUserFromFirestore(){
    FirebaseServices.firestore.collection("users").doc(widget.userId).get().then((value){
      if(value.exists){
        if(value.data()!["imageUrl1"] != null){
          setState(() {
            imageUrl1 = value.data()!["imageUrl1"];
            imageUrl2 = value.data()!["imageUrl2"];
            imageUrl3 = value.data()!["imageUrl3"];
            imageUrl4 = value.data()!["imageUrl4"];
            imageUrl5 = value.data()!["imageUrl5"];
          });

        }
        setState(() {
          fullname= value.data()!['fullname'];
          age = value.data()!['age'];
          phone= value.data()!['phone'];
          country= value.data()!['country'];
          city= value.data()!['city'];
          profileHeading= value.data()!['profileHeading'];
          lookingForPartner= value.data()!['lookingForPartner'];
          gender= value.data()!['gender'];

          height= value.data()!['height'];
          weight= value.data()!['weight'];
          bodyType= value.data()!['bodyType'];

          drink= value.data()!['drink'];
          smoke= value.data()!['smoke'];
          maritalStatus= value.data()!['maritalStatus'];
          haveChildren= value.data()!['haveChildren'];
          noOfChildren= value.data()!['noOfChildren'];
          profession= value.data()!['profession'];
          employmentStatus= value.data()!['employmentStatus'];
          incoming= value.data()!['incoming'];
          livingSituation= value.data()!['livingSituation'];
          willingToRelocate= value.data()!['willingToRelocate'];
          relationshipYouLookingFor= value.data()!['relationshipYouLookingFor'];

          nationality= value.data()!['nationality'];
          ethnicity= value.data()!['ethnicity'];
          education= value.data()!['education'];
          religion= value.data()!['religion'];
          languageSpoken= value.data()!['languageSpoken'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataUserFromFirestore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF123880),
        title: const Text("Mon Profil"),
        centerTitle: true,
        // automaticallyImplyLeading: widget.userId == FirebaseServices.userCurrentId ?false:true,
        leading:widget.userId == FirebaseServices.userCurrentId ?
        IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined,size: 30,)
        ) :Container(),
        actions: [
          widget.userId == FirebaseServices.userCurrentId ?
          Row(
            children: [
              IconButton(onPressed: (){FirebaseServices().sigOut();},icon: Icon(Icons.logout,size: 30,)),
              IconButton(onPressed: (){Get.to(AccountSettingsScreen());},icon: Icon(Icons.settings,size: 30,)),
            ],
          ) : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Color(0xFF123880).withAlpha(10),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Color(0xFF123880),
                    animationPageCurve: Curves.bounceIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(imageUrl1 , fit: BoxFit.fill,),
                      Image.network(imageUrl2 , fit: BoxFit.fill,),
                      Image.network(imageUrl3 , fit: BoxFit.fill,),
                      Image.network(imageUrl4 , fit: BoxFit.fill,),
                      Image.network(imageUrl5 , fit: BoxFit.fill,),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Informations personnelles",
                  style: TextStyle(
                    color: Color(0xFF123880),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "Nom: ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17
                          ),
                        ),

                        Text(
                          fullname,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18
                          ),
                        ),

                      ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Age: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            "${age.toString()} ans",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Genre: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            gender,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Pays: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            country,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Ville habitation: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            city,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            profileHeading,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Telephone: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            phone,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Ce que vous recherchez : ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            lookingForPartner,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              //APPARENCES
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Apparences",
                  style: TextStyle(
                    color: Color(0xFF123880),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Text(
                            "Taille: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            height,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Poids: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            "${weight.toString()} Kg",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Physique: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            bodyType,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                  ],
                ),
              ),
              //Lifestyle
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LifeStyle",
                  style: TextStyle(
                    color: Color(0xFF123880),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Text(
                            "Alcoolisme: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            drink,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Tabagisme: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            smoke,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Situation matrimoniale: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            maritalStatus,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Avez-vous des enfants?: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            haveChildren,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Nombres d'enfants: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            noOfChildren,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Revenus annuels: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            incoming,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Profession: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            profession,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Situation professionnelle : ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            employmentStatus,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Type logement : ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            livingSituation,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Mobilité geographique: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            willingToRelocate,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Type de relation recherchée: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            relationshipYouLookingFor,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),

                  ],
                ),
              ),
              //BACKGROUND
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background",
                  style: TextStyle(
                    color: Color(0xFF123880),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Text(
                            "Nationalité: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            nationality,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Origine ethnique: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            ethnicity,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Diplomes: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            education,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Religion: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            religion,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),
                    TableRow(
                        children: [
                          Text(
                            "Les langues: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17
                            ),
                          ),

                          Text(
                            languageSpoken,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18
                            ),
                          ),

                        ]
                    ),


                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
