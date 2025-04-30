import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/authentication_screen/login_screen.dart';
import 'package:datingapp/homeScreen/home_screen.dart';
import 'package:datingapp/utils/cloudinary.dart';
import 'package:datingapp/utils/error.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/person.dart';

class AuthController extends GetxController{

  late Rx<User?> firebaseCurrentUser;
  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;
  var isLoading = false.obs;

  pickImageFileFromGallery() async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imageFile != null){
      Get.snackbar("Profile Image", "vous avez choisi avec succès votre image de profil",
          colorText: Colors.white , backgroundColor: Color(0xFF123880));
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromPhoneCamera() async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(imageFile != null){
      Get.snackbar("Profile Image", "Votre image de profil a été capturée avec succès",colorText: Colors.white , backgroundColor: Color(0xFF123880));
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  createNewUserAccount({
    required String emailAddress,
    File? imageUrl,
    required String fullname,
    String? password,
    required String age,
   required String phone,
   required String country,
   required String city,
   required String profileHeading,
   required String lookingForPartner,
   required String gender,
   required String height,
   required String weight,
   required String bodyType,
   required String drink,
   required String smoke,
   required String maritalStatus,
   required String haveChildren,
   required String noOfChildren,
   required String profession,
   required String employmentStatus,
   required String incoming,
   required String livingSituation,
   required String willingToRelocate,
   required String relationshipYouLookingFor,
   required String nationality,
   required String ethnicity,
   required String education,
   required String religion,
   required String languageSpoken,
    required BuildContext context,
  })async{
    try{
      isLoading.value = true;
      if(emailAddress.isEmpty || fullname.isEmpty ){
        showCustomizeDialog(context: context,
            title: "erreur",
            content: "Veuillez remplir tous les champs obligatoires."
        );

        isLoading.value = false;
        return;
      }
      if(imageFile == null){
        showCustomizeDialog(
          context: context,
          title: "Image requise",
          content: "Veuillez sélectionner une image de profil.",
        );
        isLoading.value = false;
        return;
      }

      // Upload de l'image vers Cloudinary
      String? imageUrl = await uploadToCloudinary(imageFile) ;

      // Création du compte Firebase Auth
      UserCredential userCredential = await FirebaseServices().createUserWithEmailAndPassword(email: emailAddress, password: password!);

      // Création de l'objet Person
      Person newUserData = Person(
        uid: userCredential.user!.uid,
        imageUrl: imageUrl,
        email: emailAddress,
        fullname: fullname,
        age: int.parse(age),
        phone: phone,
        gender: gender,
        country: country,
        city: city,
        profileHeading: profileHeading,
        lookingForPartner: lookingForPartner,

        height: height,
        weight: weight,
        bodyType: bodyType,

        drink: drink,
        smoke: smoke,
        maritalStatus: maritalStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        employmentStatus: employmentStatus,
        profession: profession,
        incoming: incoming,
        livingSituation: livingSituation,
        willingToRelocate: willingToRelocate,
        relationshipYouLookingFor: relationshipYouLookingFor,

        education: education,
        ethnicity: ethnicity,
        religion: religion,
        nationality: nationality,
        languageSpoken: languageSpoken,

        publishedDateTime:DateTime.now(),
      );

      // Sauvegarde des données dans Firestore
      await FirebaseServices.firestore.collection("users").doc(userCredential.user!.uid).set(newUserData.toJson());


      Get.snackbar(
        "Succès",
        "Votre compte a été créé avec succès.",
        backgroundColor: Color(0xFF123880),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.to(HomeScreen());
      return newUserData;

    }
    catch(error){
    showCustomizeDialog(
        context : context,
        title: "erreur",
        content: "Probleme rencontré lors de la creation d'un compte:${error.toString()}",
    );
    }
  }

  logInUser({
    required String email,
    required String password,
    required BuildContext context,
})async{
    try{
      isLoading.value = true;
      // verifier si les champs sont vides
      if(email.isEmpty || password.isEmpty){
        showCustomizeDialog(context: context,
            title:"Erreur",
            content: "Veuillez saisir votre email et Mot de passe"
        );
        isLoading.value = false;
        return;
      }
      // Authentification depuis Firebase Auth
      UserCredential userCredential = await FirebaseServices().signInUserWithEmailAndPassword(email: email, password: password);

      //Verification s'il existe dans la base de données firestore
      DocumentSnapshot userDoc = await FirebaseServices.firestore.collection("users").doc(userCredential.user!.uid).get();
      if(!userDoc.exists){
        showCustomizeDialog(
          context: context,
          title: "Erreur",
          content: "Aucun compte trouvé pour cet utilisateur.",
        );
        isLoading.value = false;
        return;
      }
      Get.snackbar(
        "Connexion réussie",
        "Bienvenue sur l'application!",
        backgroundColor: Color(0xFF123880),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.offAll(HomeScreen());
    }
    catch(error){
      String errorMessage = "Une erreur s'est produite lors de la connexion.";

      if(error is FirebaseAuthException){
        switch(error.code){
          case 'user-not-found':
            errorMessage = "Aucun utilisateur trouvé avec cet email.";
            break;
          case 'wrong-password':
            errorMessage = "Mot de passe incorrect.";
            break;
          case 'invalid-email':
            errorMessage = "Format d'email invalide.";
            break;
          case 'user-disabled':
            errorMessage = "Ce compte a été désactivé.";
            break;
          case 'too-many-requests':
            errorMessage = "Trop de tentatives de connexion. Veuillez réessayer plus tard.";
            break;
        }
      }
      showCustomizeDialog(
        context: context,
        title: "Erreur de connexion",
        content: errorMessage,
      );

    }
    finally{
      isLoading.value = false;
    }


  }

  checkIfUserAlreadyRegister(User? currentUser ){
    if(currentUser == null){
      Get.to(LoginScreen());
    }
    else{
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseServices.auth.currentUser);
    firebaseCurrentUser.bindStream(FirebaseServices.auth.authStateChanges());
    ever(firebaseCurrentUser, checkIfUserAlreadyRegister);
  }

}