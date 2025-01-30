import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
      final user = FirebaseAuth.instance.currentUser;
      FirestoreService firestoreService = FirestoreService();
      final BottomNavigationController itemController = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hesabım'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('data')
          ),
          TextButton(onPressed: () async {
            await firestoreService.logoutUser();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePageView()));
          }, child: Text('çıkış yap'))
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value, 
        onItemTapped : (index) => itemController.onItemTapped(index)),
    );
  }
}