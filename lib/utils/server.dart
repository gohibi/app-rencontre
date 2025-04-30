import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

class ServiceAccountHelper {
  static final _serviceAccountCredentials = ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "datingapp-b6b68",
    "private_key_id": "2cf16fe08fed547f3d54fe575599e97696a6d3bf",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD4c2TaM72oeXL/\nai2vM6p9MVLKP7iG2mTy+UP/q+xfGdOnZuSKes1rtT9k5n5m5rWPwQ81tjHgl0De\nPCGBF2xt0rOf/S2RGJ6+0ibvlrzHMBwTra/Vc4my1ViG0CaUv9/po/9P0+OnemLT\nIE1a+pRTJzF0vaKST2Ky3LPl6GmWHYFqy7pam2+fepb0AyZ20cp0dvtfYqe0h0Qs\nBLAJhvQ4kiFdBVOehjg68t9AEsUs+zmIybkiAfItcq1mLTQs4CG9Ml628EHxlLpX\nL1ywaEN2hDeUGH5+OLZpn2LTcZavL6FeiZScg3mKbLYogJggwDA75l/XfGaF7j0T\n7q8pMsx1AgMBAAECggEAL+kgw6tCoaB5+qMhGC4gbG/8hR/wl6C54tkKsd0Xgedb\nF2cSH1o7DtAu32hLa9CFpqkWI8d0qtjAG5sA4wH/WNZO6UVLajWTNz0TYRRyZv7y\nCyFtTP4wyZm2rpipN/ogVc/YRi6YMg25zPjnsemsfLSMJvUCyrAgWlmRH37IDbhV\nnXTdKdAqcWUMHq8Np+myu/TczsF3NI4J58Djyd6iCtBOu9n54aaFOEhZ6mlqtm9W\nfjaPXfBGCsyyt+AtqCFVJVVCsaHgX0D1unR8uSuTGQTsAGGx7FIxcDHd89h5RkSG\n/4RMLnHUb9/K0LPG3w4ReO+DeauhMjhOmnLKgritaQKBgQD+BKjVfpvnl26nDGGq\nvOS2hwPU2WwO416xuYjPPSFev1eDnCVcHY+DQ/+6hLxs897hDDa2UqHjlfcz1SH4\n6lnnseY5i116PRJ4aVCUlXm956IwIwBjPAwaV0jWc8CC0a208GFvkcTEsA3WTnvK\n3vugA/n6CIsiMPmnT56ZWGcWNwKBgQD6Y51kVtisqfIj7bl1wFcWKajvmIM3qsSJ\nasU3J/zR2UcQE7/i2Y6ST1t1s4gnCysS0FVRjoWIG7Nux1ASdRBuK6is/chMHk0V\nvdu4Jm5qPZLOVTpApsPZPO5YudLsbmzz7JyA3ouaHt99B/K94r8VXQ27Ocrsn/Rd\npDLQyrHcswKBgQD2qGOhXB3blopWH4m/F0knjJdF2hI5qsNK5JRaWEvNCxPZsof8\nmJ/AoQjzfuzRB0XHVerSxA57RiYS6MTiRf4jI/YgrpmIl0EWN32Nqk/a/c/Z2kMI\nGUjPUy5hP2kSHrUEW97hTbS6IRJupStD5Z6E1RepmR4xh0kFFCU3VkZTpQKBgQDK\nBkHhyai9d8mlb5OqDGy3txlVaErHSYOWFI3XOO5mKteJg0XZtQuxxVHYH+kFB5/T\naEDOsx3OeftGsI5MtiNxoMxR99n6gKBVoIB9jpScJ94hmOaNb4Cp8N2mvRgQJ/DE\nxu5nlCgzTCGqchVLXH4ssI35uGGgllbGj0to54KmvQKBgGm3ubWWLSrrCx/PHyTc\ncZ2Aj2KdLS6NqsqTjvfhm+lpwNRGjQnmUecuzQ7nxhkc5JA42IEx4jcCDj+sGfAh\n2mJMdqdj9KxpJE7aYHF90b9+a5d8GHK+oRq/3Kk2iMADkPLIqYJ+cq5Gua5+qDMk\neNH0hD4lQnfZYbKlZZlrrnud\n-----END PRIVATE KEY-----\n",
    "client_email": "tinder-clone-app-flutter@datingapp-b6b68.iam.gserviceaccount.com",
    "client_id": "112600279615110827763",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tinder-clone-app-flutter%40datingapp-b6b68.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
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
List<String> scopes = [
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/firebase.database",
  "https://www.googleapis.com/auth/firebase.messaging",
];*/
