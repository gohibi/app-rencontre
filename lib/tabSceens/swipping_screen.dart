import 'package:datingapp/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {

  ProfileController profileController = Get.put(ProfileController());

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
              return DecoratedBox(
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
                          padding: const EdgeInsets.only(top:8),
                          child: IconButton(
                              onPressed: (){},
                              icon: Icon(
                                  Icons.filter_list_outlined,
                                size: 32,
                                color: Color(0xFF123880),
                              )
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Column(
                          children: [
                            Text(
                              infoProfileUser.fullname.toString(),
                              style: TextStyle(),
                            )
                          ],
                          //afficher le nom

                        ),
                      )

                    ],
                  ),
                ),
              );
            },
          );
        })
    );
  }
}
