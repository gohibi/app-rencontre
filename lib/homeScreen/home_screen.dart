import 'package:datingapp/pushNotificationsSystem/push_notifications_system.dart';
import 'package:datingapp/tabSceens/favorite_sent_favorite_received_screen.dart';
import 'package:datingapp/tabSceens/like_sent_like_received_screen.dart';
import 'package:datingapp/tabSceens/swipping_screen.dart';
import 'package:datingapp/tabSceens/user_detail_screen.dart';
import 'package:datingapp/tabSceens/view_sent_view_received_screen.dart';
import 'package:datingapp/utils/firebase.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List screenTabs = [
    SwippingScreen(),
    UserDetailScreen(userId: FirebaseServices.auth.currentUser!.uid,),
    ViewSentViewReceivedScreen(),
    LikeSentLikeReceivedScreen(),
    FavoriteSentFavoriteReceivedScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.generateDeviceRegistrationToken();
    pushNotificationSystem.whenNotificationsReceived(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor:Color(0xFF123880),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'Vues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoris',
          )
        ],

      ),
      body: screenTabs[_selectedIndex]
    );
  }
}
