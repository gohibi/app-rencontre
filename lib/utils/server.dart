import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class ServiceAccountHelper {
  static final _serviceAccountCredentials = ServiceAccountCredentials.fromJson({

  });

  static final _scopes = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];
  static Future<AccessToken> getAccessToken() async {
    final authClient = await clientViaServiceAccount(
      _serviceAccountCredentials,
      _scopes,
    );
    return authClient.credentials.accessToken;
  }
}


/*

*/
/*
List<String> scopes = [
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/firebase.database",
  "https://www.googleapis.com/auth/firebase.messaging",
];*//*
*/
/*

*/
