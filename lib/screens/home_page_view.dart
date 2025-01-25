import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/services/firestore.dart';
import 'package:tatli_sozluk/viewModel/bottom_navigation_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});
    
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TextEditingController textEditingController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
  final BottomNavigationController itemController = Get.put(BottomNavigationController());
  void openTitleBox() {
      showDialog(context: context, builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: 'Başlık giriniz',
            labelText: 'Başlık',
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            firestoreService.addTitle(textEditingController.text);
            textEditingController.clear();
            Navigator.of(context).pop();
          },
          child: Text('Ekle')
          )
        ],
      ));
    } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Anasayfa'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTitles(),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            List titlesList = snapshot.data!.docs;
            return ListView.builder(
            itemCount: titlesList.length,
            itemBuilder: (context,index){
              DocumentSnapshot document = titlesList[index];
              String docID = document.id;
              Map<String,dynamic> data = document.data() as Map<String,dynamic>;
              String titleText = data['title'];
      
              return ListTile(
                title: Text(titleText),
              );
            });
          }
          else {
            return const Text('no data');
          }
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: openTitleBox,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx( () => CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value,
        onItemTapped : (index) => itemController.onItemTapped(index),
      )),
    );
  }
}