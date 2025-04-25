import 'dart:io';

import 'package:datingapp/authentication_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auht_controller.dart';
import '../widgets/custom_field_text.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Informations personnelles
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController = TextEditingController();
  TextEditingController lookingForPartnerTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();

  //Apparences
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //LifeStyle
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController maritalStatusTextEditingController = TextEditingController();
  TextEditingController haveChildrenTextEditingController = TextEditingController();
  TextEditingController noOfChildrenTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  TextEditingController employmentStatusTextEditingController = TextEditingController();
  TextEditingController incomingTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController = TextEditingController();
  TextEditingController willingToRelocateTextEditingController = TextEditingController();
  TextEditingController relationshipYouLookingForTextEditingController = TextEditingController();


  //Education ,Valeurs , religion ,nationalié
  TextEditingController nationalityTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController = TextEditingController();
  TextEditingController educationTextEditingController = TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController languageSpokenTextEditingController = TextEditingController();

  String? selectedGender;

  bool showProgressBar = false;

  var authController = AuthController.authenticationController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const  Text(
                "Creation de compte",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xFF123880)
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "pour commencer maintenant",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xFF123880)
                ),
              ),

              const SizedBox(
                height: 30,

              ),

              //image avatar
              authController.imageFile == null ?
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                  "images/userp.png",
                ),
                backgroundColor: Colors.black,
              ): Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(
                      File(authController.imageFile!.path)
                    )
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async{
                        await authController.captureImageFromPhoneCamera();
                        setState(() {
                          authController.imageFile;
                        });
                      },
                      icon: Icon(Icons.camera_alt_outlined,color:Colors.grey , size: 30,)
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                      onPressed: ()async{
                          await authController.pickImageFileFromGallery();
                          setState(() {
                            authController.imageFile;
                          });
                        },
                      icon: Icon(Icons.image_outlined ,color:Colors.grey , size: 30,)
                  ),

                ],
              ),
              const SizedBox(
                height: 30,

              ),

              //informations personnelles debut
              Center(child: Text("INFORMATIONS PERSONNELLES", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 , color: Color(0xFF123880)),),),
              const SizedBox(height: 10,),
              //Email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.emailAddress,
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  editingController: passwordTextEditingController,
                  labelText: "Mot de passe",
                  iconData: Icons.lock_outlined,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,

              ),

              // fullname
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: fullnameTextEditingController,
                  labelText: "Nom complet",
                  iconData: Icons.person,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //age
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: ageTextEditingController,
                  labelText: "Quel age aviez-vous?",
                  iconData: Icons.numbers_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 15,

              ),

              //gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Sexe",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Homme" ,style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold),),
                          value: "Homme",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          activeColor: Color(0xFF123880), // Couleur de sélection
                          tileColor: Colors.grey[100], // Fond des tuiles
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Femme",style: TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
                          value: "Femme",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          activeColor: Color(0xFF123880), // Couleur de sélection
                          tileColor: Colors.grey[100], // Fond des tuiles
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
             const SizedBox(height: 10,),
             /* SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  editingController: genderTextEditingController,
                  labelText: "Sexe",
                  iconData: Icons.male,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),*/
              //pays
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: countryTextEditingController,
                  labelText: "Pays",
                  iconData: Icons.location_pin,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //ville
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: cityTextEditingController,
                  labelText: "ville",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //phone
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.phone,
                  editingController: phoneTextEditingController,
                  labelText: "Numero telephone",
                  iconData: Icons.phone,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //profile heading
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController:profileHeadingTextEditingController,
                  labelText: "Description",
                  iconData: Icons.text_fields,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //lookingforpartner
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: lookingForPartnerTextEditingController,
                  labelText: "Ce que vous recherchez chez un partenaire ?",
                  iconData: Icons.face,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),

              //informations personnelles fin

              //apparences physiques debut
              Center(child: Text("APPARENCES", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 , color: Color(0xFF123880)),),),
              const SizedBox(height: 10,),

              // taille
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: heightTextEditingController,
                  labelText: "Votre taille",
                  iconData: Icons.straighten_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),
              //poids
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: weightTextEditingController,
                  labelText: "Quel est votre poids?",
                  iconData: Icons.fitness_center_rounded,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              //description de la morphologie physique
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: bodyTypeTextEditingController,
                  labelText: "Votre morphologie",
                  iconData: Icons.accessibility_new_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,

              ),
              // apprences physiques fin


              //Style de vie

              Center(child: Text("LIFESTYLE", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 , color: Color(0xFF123880)),),),
              const SizedBox(height: 10,),
              // Consommation alcool
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: drinkTextEditingController,
                  labelText: "Consommation d'alcool",
                  iconData: Icons.local_drink_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),
              //Tabagisme
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: smokeTextEditingController,
                  labelText: "Tabagisme",
                  iconData: Icons.smoking_rooms_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30),
              //Statut marital
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: maritalStatusTextEditingController,
                  labelText: "Situation matrimoniale",
                  iconData: Icons.people_alt_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Présence d'enfants
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: haveChildrenTextEditingController,
                  labelText: "Avez-vous des enfants?",
                  iconData: CupertinoIcons.person_3_fill,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Nombre d'enfants
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: noOfChildrenTextEditingController,
                  labelText: "Nombre d'enfants",
                  iconData: CupertinoIcons.person_3,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Profession
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: professionTextEditingController,
                  labelText: "Votre profession",
                  iconData: Icons.work_outline,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Situation professionnelle
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: employmentStatusTextEditingController,
                  labelText: "Situation professionnelle",
                  iconData: Icons.business_center_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),



              //Revenus
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: incomingTextEditingController,
                  labelText: "Revenus",
                  iconData: CupertinoIcons.money_rubl_circle,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Logement
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: livingSituationTextEditingController,
                  labelText: "Logement",
                  iconData: Icons.home_filled,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Mobilité geographique
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: willingToRelocateTextEditingController,
                  labelText: "Voulez-vous déménager",
                  iconData: Icons.directions_run_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Type de relation recherchée
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: relationshipYouLookingForTextEditingController,
                  labelText: "Type de relation recherchée",
                  iconData: Icons.favorite_outline_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Style de vie

              //Bcakground et autres...(debut)
              Center(child: Text("EDUCATION ET VALEURS", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 , color: Color(0xFF123880)),),),
              const SizedBox(height: 10,),
              //Religion
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: religionTextEditingController,
                  labelText: "Votre religion",
                  iconData: CupertinoIcons.moon,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30),
              //Nationalité
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: nationalityTextEditingController,
                  labelText: "Nationalité",
                  iconData: Icons.flag,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Origine ethnique
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: ethnicityTextEditingController,
                  labelText: "Origine ethnique",
                  iconData: CupertinoIcons.group_solid,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Niveau d'études
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: educationTextEditingController,
                  labelText: "Niveau d'études",
                  iconData: Icons.school_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),

              //Langues parlées
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.text,
                  editingController: languageSpokenTextEditingController,
                  labelText: "Langue parlée",
                  iconData: Icons.language_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 30,),


              //Bcakground et autres...(fin)


              const SizedBox(
                height: 30,
              ),

              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xFF123880),
                    borderRadius: BorderRadius.all(
                        Radius.circular(8)
                    )
                ),
                child: InkWell(
                  onTap: () async{
                      if(authController.profileImage != null){
                        final List<TextEditingController> allTextControllers = [
                          emailTextEditingController,
                          passwordTextEditingController,
                          fullnameTextEditingController,
                          ageTextEditingController,
                          phoneTextEditingController,
                          countryTextEditingController,
                          cityTextEditingController,
                          profileHeadingTextEditingController,
                          lookingForPartnerTextEditingController,

                          heightTextEditingController,
                          weightTextEditingController,
                          bodyTypeTextEditingController,

                          drinkTextEditingController,
                          smokeTextEditingController,
                          maritalStatusTextEditingController,
                          haveChildrenTextEditingController,
                          noOfChildrenTextEditingController,
                          professionTextEditingController,
                          employmentStatusTextEditingController,
                          incomingTextEditingController,
                          livingSituationTextEditingController,
                          willingToRelocateTextEditingController,
                          relationshipYouLookingForTextEditingController,

                          nationalityTextEditingController,
                          ethnicityTextEditingController,
                          educationTextEditingController,
                          religionTextEditingController,
                          languageSpokenTextEditingController,
                        ];
                        bool isAnyTextFieldEmpty = allTextControllers.any((controller) => controller.text.trim().isEmpty);
                        bool isGenderSelected = selectedGender != null;
                        if(!isAnyTextFieldEmpty || !isGenderSelected){
                          setState(() {
                            showProgressBar = true;
                          });
                           await authController.createNewUserAccount(
                                imageUrl: authController.profileImage,
                                emailAddress: emailTextEditingController.text.trim(),
                                fullname:fullnameTextEditingController.text.trim() ,
                                password: passwordTextEditingController.text.trim(),
                                age: ageTextEditingController.text.trim(),
                                phone: phoneTextEditingController.text.trim(),
                                country: countryTextEditingController.text.trim(),
                                city: cityTextEditingController.text.trim(),
                                profileHeading: profileHeadingTextEditingController.text.trim(),
                                lookingForPartner: lookingForPartnerTextEditingController.text.trim(),
                                gender: selectedGender.toString(),

                                height: heightTextEditingController.text.trim(),
                                weight: weightTextEditingController.text.trim(),
                                bodyType: bodyTypeTextEditingController.text.trim(),

                                drink: drinkTextEditingController.text.trim(),
                                smoke: smokeTextEditingController.text.trim(),
                                maritalStatus: maritalStatusTextEditingController.text.trim(),
                                haveChildren: haveChildrenTextEditingController.text.trim(),
                                noOfChildren: noOfChildrenTextEditingController.text.trim(),
                                profession: professionTextEditingController.text.trim(),
                                employmentStatus: employmentStatusTextEditingController.text.trim(),
                                incoming: incomingTextEditingController.text.trim(),
                                livingSituation: livingSituationTextEditingController.text.trim(),
                                willingToRelocate: willingToRelocateTextEditingController.text.trim(),
                                relationshipYouLookingFor: relationshipYouLookingForTextEditingController.text.trim(),

                                nationality: nationalityTextEditingController.text.trim(),
                                ethnicity: ethnicityTextEditingController.text.trim(),
                                education: educationTextEditingController.text.trim(),
                                religion: religionTextEditingController.text.trim(),
                                languageSpoken: languageSpokenTextEditingController.text.trim(),
                                context: context,
                           );
                           setState(() {
                             showProgressBar = false;
                             authController.imageFile = null;
                           });
                        } else{
                          Get.snackbar("Un champ est vide", "Veuillez remplir tous les champs" ,backgroundColor: Color(0xFF123880),
                              colorText: Colors.white);
                        }
                      }else{
                        Get.snackbar("Fichier image manquant", "Veuillez choisir une image dans la galerie ou la capturer avec un appareil photo"
                        ,backgroundColor: Color(0xFF123880),
                            colorText: Colors.white
                        );
                      }
                  },
                  child: Center(
                    child:showProgressBar?CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ) :Text(
                      "Créer un compte",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(" Deja un compte? ", style: TextStyle(fontSize: 16,color: Colors.black),),
                  InkWell(
                      onTap: (){
                        Get.to(LoginScreen());
                      },
                      child: Text("Connectez-vous directement", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w900 , color: Color(0xFF123880)),)
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              showProgressBar == true ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent.withAlpha(20)),
              ) : Container()


            ],
          ),
        ),
      ),
    );
  }
}
