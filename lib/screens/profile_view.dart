// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';
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
        actions: [
          IconButton(onPressed: () async{
            await firestoreService.logoutUser();
          }, icon: Icon(Iconsax.logout_1))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(foregroundImage: NetworkImage('https://picsum.photos/250?image=9'),
              radius: 50,
              ),
            ),
            Text(user!.email!, style: TextStyle(fontSize: 16),),
            SizedBox(height: 20),
            Divider(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('entry sayisi'),
                Text('favoriler'),
                Text('düzenle'),
              ],
            ),
            Divider(height: 10)
          ],
        )
        ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value, 
        onItemTapped : (index) => itemController.onItemTapped(index)),
    );
  }
}