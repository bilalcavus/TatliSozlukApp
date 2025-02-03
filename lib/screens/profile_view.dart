// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/components/custom_colors.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';
import 'package:tatli_sozluk/controller/title_op_controller.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = FirebaseAuth.instance.currentUser;
  final FirestoreService firestoreService = FirestoreService();
  final BottomNavigationController itemController = Get.put(BottomNavigationController());
  final TitleOpController controller = Get.put(TitleOpController());

  @override
  Widget build(BuildContext context) {
    void openTitleBox() {
      showDialog(context: context, builder: (context) => AlertDialog(
        content: TextField(
          controller: controller.textEditingController,
          decoration: const InputDecoration(
            hintText: 'Başlık giriniz',
            labelText: 'Başlık',
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            controller.firestoreService.addTitle(controller.textEditingController.text);
            controller.textEditingController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePageView()));
          },
          child: Text('Ekle')
          )
        ],
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('hesabım'),
        actions: [
          IconButton(onPressed: () async{
            await firestoreService.logoutUser();
          }, icon: Icon(Iconsax.logout_1))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 75),
                  child: Text(user!.email!, style: TextStyle(fontSize: 16),),
                ),
                CircleAvatar(foregroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                radius: 50,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('entrylerim'),
              Text('favoriler'),
              Text('düzenle'),
            ],
          ),
          Divider(height: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors().floatingActionButtonColor,
        foregroundColor: Colors.black,
        onPressed: openTitleBox,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value, 
        onItemTapped : (index) => itemController.onItemTapped(index)),
    );
  }

  
}