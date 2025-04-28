import 'package:datingapp/tabSceens/user_detail_screen.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSentViewReceivedScreen extends StatefulWidget {
  const ViewSentViewReceivedScreen({super.key});

  @override
  State<ViewSentViewReceivedScreen> createState() => _ViewSentViewReceivedScreenState();
}

class _ViewSentViewReceivedScreenState extends State<ViewSentViewReceivedScreen> {
  bool isViewSentCLicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewsList = [];

  getLikeListKeys() async{

    if(isViewSentCLicked){
      var documentViewSent = await FirebaseServices.firestore
          .collection("users")
          .doc(FirebaseServices.userCurrentId.toString())
          .collection("viewSent")
          .get();

      for(int i=0 ; i<documentViewSent.docs.length; i++){
        viewSentList.add(documentViewSent.docs[i].id);
      }
      getKeysDataFromUserCollection(viewSentList);
    }else{
      var documentViewReceived = await  FirebaseServices.firestore
          .collection("users")
          .doc(FirebaseServices.userCurrentId.toString())
          .collection("viewReceived")
          .get();
      for(int i=0 ; i<documentViewReceived.docs.length; i++){
        viewReceivedList.add(documentViewReceived.docs[i].id);
      }
      getKeysDataFromUserCollection(viewReceivedList);

    }



  }

  getKeysDataFromUserCollection(List<String> keyList) async{
    var allUsersDocument = await FirebaseServices.firestore.collection("users").get();
    for(int i=0; i<allUsersDocument.docs.length; i++){

      for(int k=0; k<keyList.length; k++){

        if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keyList[k]){

          viewsList.add(allUsersDocument.docs[i].data());
        }
      }

    }
    setState(() {
      viewsList;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikeListKeys();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFF123880),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: (){
                    viewsList.clear();
                    viewsList=[];
                    viewSentList.clear();
                    viewSentList=[];
                    viewReceivedList.clear();
                    viewReceivedList =[];
                    setState(() {
                      isViewSentCLicked =true;
                    });
                    getLikeListKeys();
                  },
                  child: Text("Mes vues",style: TextStyle(
                      fontSize: 18,
                      color: isViewSentCLicked? Colors.red : Colors.white,
                      fontWeight: isViewSentCLicked? FontWeight.bold : FontWeight.w500

                  ),
                    overflow: TextOverflow.ellipsis,
                  )
              ),
              const Text("|" , style: TextStyle(fontWeight: FontWeight.bold),),
              TextButton(
                  onPressed: (){
                    viewsList.clear();
                    viewsList=[];
                    viewSentList.clear();
                    viewSentList=[];
                    viewReceivedList.clear();
                    viewReceivedList =[];

                    setState(() {
                      isViewSentCLicked = false;
                    });
                    getLikeListKeys();
                  },
                  child: Text("Leurs vues",style: TextStyle(
                      fontSize: 18,
                      color: isViewSentCLicked? Colors.white: Colors.red,
                      fontWeight: isViewSentCLicked? FontWeight.normal : FontWeight.w400

                  ),
                    overflow: TextOverflow.ellipsis,
                  )
              ),

            ],
          ),
        ),
      ),
      body: viewsList.isEmpty
          ? Center(
        child: Icon(
          Icons.person_off_sharp,
          color: Color(0xFF123880),
          size: 60,
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75, // ajustement pour meilleure mise en page
        ),
        itemBuilder: (context, index) {
          final user = viewsList[index];
          return GestureDetector(
            onTap: () {
               Get.to(UserDetailScreen(userId:user["uid"].toString() ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        user["imageUrl"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black.withAlpha(30), // léger voile noir
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Center(
                            child: Text(
                              user["fullname"].toString().toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Center(
                            child: Text(
                              "${user["age"].toString()} ans",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${user["city"]} ● ${user["country"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),


    );
  }
}
