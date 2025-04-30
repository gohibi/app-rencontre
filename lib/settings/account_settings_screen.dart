import 'dart:io';
import 'package:datingapp/homeScreen/home_screen.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/cloudinary_2.dart';
import '../widgets/custom_field_text.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool uploading = false;
  bool next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController = TextEditingController();
  TextEditingController lookingForPartnerTextEditingController = TextEditingController();


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

  bool showProgressBar = false;

  String fullname="";
  int? age ;
  String phone="";
  String country="";
  String city="";
  String profileHeading="";
  String lookingForPartner="";
  String gender="";
  String imageUrl ="";

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

  chooseImage() async {
       XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

       setState(() {
         _image.add(File(pickedFile!.path));
       });
  }

 /* uploadImages() async{
    int i = 1;
    for(var img in _image){
      setState(() {
        val = i / _image.length;
      });

      var refImages = FirebaseStorage
          .instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img).whenComplete(()async{
        await refImages.getDownloadURL().then((imageUrl){
            urlsList.add(imageUrl);
            i++;
        });
      });
    }

  }*/
  uploadImages() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      // Convertir File en XFile pour Cloudinary
      XFile xFile = XFile(img.path);

      String? imageUrl = await uploadToCloudinary2(xFile);

      if (imageUrl != null) {
        urlsList.add(imageUrl);
        i++;
      }
    }
  }

  retrieveUserData() async{

    await FirebaseServices
        .firestore
        .collection("users")
        .doc(FirebaseServices.userCurrentId)
        .get()
        .then((snapshot){

          if(snapshot.exists){
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            setState(() {
              fullname= data['fullname'].toString();
              fullnameTextEditingController.text = fullname;
              age = data['age'] as int;
              ageTextEditingController.text = age.toString();
              phone= data['phone'].toString();
              phoneTextEditingController.text = phone;
              country= data['country'].toString();
              countryTextEditingController.text = country;
              city= data['city'].toString();
              cityTextEditingController.text = city;
              profileHeading= data['profileHeading'].toString();
              profileHeadingTextEditingController.text =profileHeading;
              lookingForPartner= data['lookingForPartner'].toString();
              lookingForPartnerTextEditingController.text = lookingForPartner;
              height= data['height'].toString();
              heightTextEditingController.text = height;
              weight= data['weight'].toString();
              weightTextEditingController.text = weight;
              bodyType= data['bodyType'].toString();
              bodyTypeTextEditingController.text = bodyType;
              drink= data['drink'].toString();
              drinkTextEditingController.text = drink;
              smoke= data['smoke'].toString();
              smokeTextEditingController.text = smoke;
              maritalStatus= data['maritalStatus'].toString();
              maritalStatusTextEditingController.text = maritalStatus;
              haveChildren= data['haveChildren'].toString();
              haveChildrenTextEditingController.text = haveChildren;
              noOfChildren= data['noOfChildren'].toString();
              noOfChildrenTextEditingController.text = noOfChildren;
              profession= data['profession'].toString();
              professionTextEditingController.text = profession;
              employmentStatus= data['employmentStatus'].toString();
              employmentStatusTextEditingController.text = employmentStatus;
              incoming= data['incoming'].toString();
              incomingTextEditingController.text = incoming;
              livingSituation= data['livingSituation'].toString();
              livingSituationTextEditingController.text = livingSituation;
              willingToRelocate= data['willingToRelocate'].toString();
              willingToRelocateTextEditingController.text = willingToRelocate;
              relationshipYouLookingFor= data['relationshipYouLookingFor'].toString();
              relationshipYouLookingForTextEditingController.text = relationshipYouLookingFor;
              nationality= data['nationality'].toString();
              nationalityTextEditingController.text = nationality;
              ethnicity= data['ethnicity'].toString();
              ethnicityTextEditingController.text = ethnicity;
              education= data['education'].toString();
              educationTextEditingController.text = education;
              religion= data['religion'].toString();
              religionTextEditingController.text = religion;
              languageSpoken= data['languageSpoken'].toString();
              languageSpokenTextEditingController.text = languageSpoken;
            });
          }
    });
  }

  updateUserDataFromFirestore({
    String? fullname, int? age, String? phone, String? country, String? city, String? profileHeading,
    String? lookingForPartner, String? height, String? weight, String? bodyType, String? drink,
    String? smoke, String? maritalStatus, String? haveChildren, String? noOfChildren,
    String? profession, String? employmentStatus, String? incoming,
    String? livingSituation, String? willingToRelocate, String? relationshipYouLookingFor, String? nationality,
    String? ethnicity, String? education, String? religion, String? languageSpoken,
})async{
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10,),
                      Text("téléchargement images...",style: TextStyle(fontSize: 16),)
                    ],
                  )
              ),
            ),
          );
        }
    );

    await uploadImages();
    
    await FirebaseServices.firestore.collection("users").doc(FirebaseServices.userCurrentId)
    .update({
      'fullname': fullname,
      'age': age,
      'phone': phone,
      'country': country,
      'city': city,
      'profileHeading': profileHeading,
      'lookingForPartner': lookingForPartner,
      'height': height,
      'weight': weight,
      'bodyType': bodyType,
      'drink': drink,
      'smoke': smoke,
      'maritalStatus': maritalStatus,
      'haveChildren': haveChildren,
      'noOfChildren': noOfChildren,
      'profession': profession,
      'employmentStatus': employmentStatus,
      'incoming': incoming,
      'livingSituation': livingSituation,
      'willingToRelocate': willingToRelocate,
      'relationshipYouLookingFor': relationshipYouLookingFor,
      'nationality': nationality,
      'ethnicity': ethnicity,
      'education': education,
      'religion': religion,
      'languageSpoken': languageSpoken,

      'imageUrl1' : urlsList[0].toString(),
      'imageUrl2' : urlsList[1].toString(),
      'imageUrl3' : urlsList[2].toString(),
      'imageUrl4' : urlsList[3].toString(),
      'imageUrl5' : urlsList[4].toString(),
    });

    Get.snackbar("Mise a jour ", "Votre compte a été mise à jour avec succès");
    Get.to(HomeScreen());
    setState(() {
      uploading = false;
      _image.clear();
      urlsList.clear();
    });
  }

  @override
  void initState() {

    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF123880),
        title: Text(
          next ? "Informations du profil" : "Choisir 5 images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
              onPressed:(){
                if(_image.length == 5){
                  setState(() {
                        uploading = true;
                        next = true;
                  });
                }
                else{
                  Get.snackbar("5 images","S'il vous plait choisissez 5 images",backgroundColor: Color(0xFF123880),
                      colorText: Colors.white);
                }
              },
              icon: Icon(Icons.navigate_next_outlined,size: 34,),
          ),
        ],
      ),
      body:  next
          ? SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text("INFORMATIONS PERSONNELLES", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18 , color: Color(0xFF123880)),),),
              const SizedBox(height: 10,),
              //fullname
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
              const SizedBox(height: 15,),
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
              const SizedBox(height: 15,),
              // phone
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 56,
                child: CustomFieldText(
                  keyboardType: TextInputType.number,
                  editingController: phoneTextEditingController,
                  labelText: "Numero de telephone",
                  iconData: Icons.numbers_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 15,),
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
              const SizedBox(height: 30,),

              // informations personnelles fin

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
                    final List<TextEditingController> allTextControllers = [
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
                    if(!isAnyTextFieldEmpty){
                      setState(() {
                        showProgressBar = true;
                      });
                      _image.length > 0 ?
                      await updateUserDataFromFirestore(
                        fullname:fullnameTextEditingController.text.trim() ,
                        age: int.parse(ageTextEditingController.text.trim()),
                        phone: phoneTextEditingController.text.trim(),
                        country: countryTextEditingController.text.trim(),
                        city: cityTextEditingController.text.trim(),
                        profileHeading: profileHeadingTextEditingController.text.trim(),
                        lookingForPartner: lookingForPartnerTextEditingController.text.trim(),


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

                      ):null;
                    } else{
                      Get.snackbar("Un champ est vide", "Veuillez remplir tous les champs" ,backgroundColor: Color(0xFF123880),
                          colorText: Colors.white);
                    }
                  },
                  child: Center(
                    child:showProgressBar?CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ) :Text(
                      "Mettre à jour votre compte",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      )
          : Stack(
          children: [
            Container(
              padding:  const EdgeInsets.all(5),
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context,index){
                    return index == 0
                        ? Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: IconButton(
                            onPressed: (){
                              if(_image.length < 5){
                                !uploading ? chooseImage() : null;
                              }else{
                                setState(() {
                                  uploading = true;
                                });
                                Get.snackbar("5 images choisies", "Les 5 images ont déjà selectionnées ",backgroundColor: Color(
                                    0xFFE63C5A),
                                    colorText: Colors.white);
                              }

                            },
                            icon: const Icon(Icons.add , size: 29,color: Color(0xFF123880),)
                        ),
                      ),
                    ) : Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                                _image[index - 1],
                            ),
                          fit: BoxFit.cover
                        )
                      ),
                    );
                  }
              ),
            )
          ],
      ),
    );
  }


}
