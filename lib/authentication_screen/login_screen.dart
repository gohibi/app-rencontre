import 'package:datingapp/authentication_screen/registration_screen.dart';
import 'package:datingapp/controllers/auht_controller.dart';
import 'package:datingapp/widgets/custom_field_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                    "images/logo.png",
                  width: 300,

                ),
               const  Text(
                      "Bienvenue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xFF123880)
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Connectez vous pour faire vos meilleures rencontres",
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 56,
                  child: CustomFieldText(
                    keyboardType: TextInputType.text,
                    editingController: passwordTextEditingController,
                    labelText: "Mot de passe",
                    iconData: Icons.lock_outlined,
                    isObscure: true,
                  ),
                ),

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
                          if(emailTextEditingController.text.trim().isNotEmpty && passwordTextEditingController.text.trim().isNotEmpty){
                            setState(() {
                              showProgressBar = true;
                            });
                            await authController.logInUser(
                                email: emailTextEditingController.text.trim(),
                                password: passwordTextEditingController.text.trim(),
                                context: context
                            );
                            setState(() {
                              showProgressBar = false;
                            });

                          }else{
                            Get.snackbar("Le champ Email ou le champ  Mot de passe est vide", "Veuillez remplir tous les champs" ,
                                backgroundColor: Color(0xFF123880),
                                colorText: Colors.white);
                          }
                    },
                    child: Center(
                      child: showProgressBar ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ):Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(" pas de compte?", style: TextStyle(fontSize: 16,color: Colors.black),),
                    InkWell(
                      onTap: (){
                        Get.to(RegistrationScreen());
                      },
                      child: Text("Créez en un ici", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w900 , color: Color(0xFF123880)),)
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
