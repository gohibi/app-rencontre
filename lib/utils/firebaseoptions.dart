import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

final String apiKeyAndroid = "AIzaSyAM-X-ngIvfPBiSrNHR3Bmxi5B6ApDNVp8";
final String appIdAndroid = "1:642047832874:android:b2c84b3e847c7ab6bfe453";
final String messagingSenderIdAndroid ="642047832874";
final String projectIdAndroid= "datingapp-b6b68";

final String apiKeyIos="";
final String appIdIos="";
final String messagingSenderIdIos="";
final String projectIdIos="";


FirebaseOptions firebaseOptions = Platform.isAndroid? FirebaseOptions(
    apiKey: apiKeyAndroid,
    appId: appIdAndroid,
    messagingSenderId: messagingSenderIdAndroid,
    projectId:projectIdAndroid
): FirebaseOptions(
    apiKey: apiKeyIos,
    appId: appIdIos,
    messagingSenderId: messagingSenderIdIos,
    projectId: projectIdIos
);