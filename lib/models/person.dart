import 'package:cloud_firestore/cloud_firestore.dart';

class Person{
// Informations personnelles
  String uid;
  String? imageUrl;
  String? email;
  String? password;
  String? fullname;
  int? age;
  String? phone;
  String? country;
  String? city;
  String? profileHeading;
  String? lookingForPartner;
  String? gender;

  // Apparence
  String? height;
  String? weight;
  String? bodyType;

  // Lifestyle
  String? drink;
  String? smoke;
  String? maritalStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? incoming;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouLookingFor;
  // Background
  String? nationality;
  String? ethnicity;
  String? education;
  String? religion;
  String? languageSpoken;

  DateTime? publishedDateTime;

  Person({
    // Informations personnelles
    required this.uid,
    this.email,
    this.password,
    this.fullname,
    this.age,
    this.phone,
    this.country,
    this.city,
    this.profileHeading,
    this.lookingForPartner,
    this.gender,
    this.imageUrl,
    this.height,
    this.weight,
    this.bodyType,
    this.drink,
    this.smoke,
    this.maritalStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.incoming,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouLookingFor,
    this.nationality,
    this.ethnicity,
    this.education,
    this.religion,
    this.languageSpoken,
    this.publishedDateTime

  });

  static Person fromDataSnapshot(DocumentSnapshot snapshot){
    var data = snapshot.data() as Map<String,dynamic>;
    return Person(
      uid: data['uid'],
      imageUrl: data['imageUrl'],
      email: data['email'],
      password: data['password'],
      fullname: data['fullname'],
      age: data['age'],
      phone: data['phone'],
      country: data['country'],
      city: data['city'],
      profileHeading: data['profileHeading'],
      lookingForPartner: data['lookingForPartner'],
      gender: data['gender'],
      height: data['height'],
      weight: data['weight'],
      bodyType: data['bodyType'],
      drink: data['drink'],
      smoke: data['smoke'],
      maritalStatus: data['maritalStatus'],
      haveChildren: data['haveChildren'],
      noOfChildren: data['noOfChildren'],
      profession: data['profession'],
      employmentStatus: data['employmentStatus'],
      incoming: data['incoming'],
      livingSituation: data['livingSituation'],
      willingToRelocate: data['willingToRelocate'],
      relationshipYouLookingFor: data['relationshipYouLookingFor'],
      nationality: data['nationality'],
      ethnicity: data['ethnicity'],
      education: data['education'],
      religion: data['religion'],
      languageSpoken: data['languageSpoken'],
        publishedDateTime: (data["publishedDateTime"] as Timestamp?)?.toDate()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'imageUrl': imageUrl,
      'email': email,
      'password': password,
      'fullname': fullname,
      'age': age,
      'phone': phone,
      'country': country,
      'city': city,
      'profileHeading': profileHeading,
      'lookingForPartner': lookingForPartner,
      'gender': gender,
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
      'publishedDateTime':publishedDateTime,
    };
  }

}