import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/material.dart';

class FavoriteSentFavoriteReceivedScreen extends StatefulWidget {
  const FavoriteSentFavoriteReceivedScreen({super.key});

  @override
  State<FavoriteSentFavoriteReceivedScreen> createState() => _FavoriteSentFavoriteReceivedScreenState();
}


class _FavoriteSentFavoriteReceivedScreenState extends State<FavoriteSentFavoriteReceivedScreen> {


  bool isFavoriteSentCLicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList = [];

  getFavoriteListKeys() async{

    if(isFavoriteSentCLicked){
      var documentFavoriteSent = await FirebaseServices.firestore
          .collection("users")
          .doc(FirebaseServices.userCurrentId.toString())
          .collection("favoriteSent")
          .get();

      for(int i=0 ; i<documentFavoriteSent.docs.length; i++){
        favoriteSentList.add(documentFavoriteSent.docs[i].id);
      }
      getKeysDataFromUserCollection(favoriteSentList);
    }else{
      var documentFavoriteReceived = await  FirebaseServices.firestore
          .collection("users")
          .doc(FirebaseServices.userCurrentId.toString())
          .collection("favoriteReceived")
          .get();
      for(int i=0 ; i<documentFavoriteReceived.docs.length; i++){
        favoriteReceivedList.add(documentFavoriteReceived.docs[i].id);
      }
      getKeysDataFromUserCollection(favoriteReceivedList);

    }



  }

  getKeysDataFromUserCollection(List<String> keyList) async{
  var allUsersDocument = await FirebaseServices.firestore.collection("users").get();
  for(int i=0; i<allUsersDocument.docs.length; i++){

    for(int k=0; k<keyList.length; k++){

      if(((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keyList[k]){

        favoritesList.add(allUsersDocument.docs[i].data());
      }
    }

  }
  setState(() {
    favoritesList;
  });
  }
  @override
  void initState() {
    super.initState();
    getFavoriteListKeys();
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
                    favoritesList.clear();
                    favoritesList=[];
                    favoriteSentList.clear();
                    favoriteSentList=[];
                    favoriteReceivedList.clear();
                    favoriteReceivedList =[];
                    setState(() {
                      isFavoriteSentCLicked =true;
                    });
                    getFavoriteListKeys();
                  },
                  child: Text("Mes favoris",style: TextStyle(
                  fontSize: 18,
                  color: isFavoriteSentCLicked? Colors.red : Colors.white,
                  fontWeight: isFavoriteSentCLicked? FontWeight.bold : FontWeight.w500

                ),
                    overflow: TextOverflow.ellipsis,
              )
              ),
              const Text("|" , style: TextStyle(fontWeight: FontWeight.bold),),
              TextButton(
                  onPressed: (){
                    favoritesList.clear();
                    favoritesList=[];
                    favoriteSentList.clear();
                    favoriteSentList=[];
                    favoriteReceivedList.clear();
                    favoriteReceivedList =[];

                    setState(() {
                      isFavoriteSentCLicked = false;
                    });
                    getFavoriteListKeys();
                  },
                  child: Text("Je suis leurs favoris",style: TextStyle(
                  fontSize: 18,
                  color: isFavoriteSentCLicked? Colors.white: Colors.red,
                  fontWeight: isFavoriteSentCLicked? FontWeight.normal : FontWeight.w400

              ),
                    overflow: TextOverflow.ellipsis,
              )
              ),

            ],
          ),
        ),
      ),
      body: favoritesList.isEmpty
          ? Center(
        child: Icon(
          Icons.person_off_sharp,
          color: Color(0xFF123880),
          size: 60,
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favoritesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75, // ajustement pour meilleure mise en page
        ),
        itemBuilder: (context, index) {
          final user = favoritesList[index];
          return GestureDetector(
            onTap: () {
              // Action au clic
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
