import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/screens/add_entry_view.dart';
import 'package:tatli_sozluk/services/firestore.dart';
import 'package:tatli_sozluk/viewModel/bottom_navigation_controller.dart';

class TitleViewPage extends StatefulWidget {
  const TitleViewPage({super.key});

  @override
  State<TitleViewPage> createState() => _TitleViewPageState();
}

class _TitleViewPageState extends State<TitleViewPage> {
    final TextEditingController textEditingController = TextEditingController();
    final BottomNavigationController itemController = Get.put(BottomNavigationController());
    final FirestoreService firestoreService = FirestoreService();
    final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String docID = args?['docID'] ?? 'docID bulunamadi';
    String titleText = args?['titleText'] ?? 'baslik bulunamadi';
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.scrim,
        title: Text(titleText),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Iconsax.pen_add5) ,
            onPressed: (){
              if (user == null) {
                Navigator.pushReplacementNamed(context, '/authPage');
              }
              else{
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => const AddEntryView(),
                  settings: RouteSettings(
                    arguments: {
                      'docID': docID,
                      'titleText': titleText,
                    },
                  ),
                ),
              );
              }
              
            },
            )
        ],
      ),
      body: Column(
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification), color: Color.fromARGB(255, 221, 185, 95),),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.sort), color: Color.fromARGB(255, 221, 185, 95),),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.search_normal4), color: Color.fromARGB(255, 221, 185, 95),),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.share), color: Color.fromARGB(255, 221, 185, 95),),
              ],
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getEntries(docID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Bir hata oluştu');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                List entriesList = snapshot.data!.docs;
                return ListView.builder(
                  
                  itemCount: entriesList.length, 
                  itemBuilder:(context, index){
                    Map<String, dynamic> data = entriesList[index].data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          title: Text(data['entryContext'], style: const TextStyle(fontSize: 15),),
                          trailing: Padding(
                            padding:  EdgeInsets.zero,
                            child: PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  height: 35,
                                  onTap: () {
                                    firestoreService.deleteEntry(docID, entriesList[index].id);
                                  },
                                  child: Icon(Icons.highlight_remove_sharp)
                                ),
                              ];
                            },),
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.heart4),),
                            const Row(
                              children: [
                                  Text('name'),
                                  SizedBox(width: 8),
                                  CircleAvatar(backgroundColor: Color.fromARGB(255, 221, 185, 95),)
                              ],
                            )
                          ],
                        ),
                        
                      ],
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: itemController.selectedIndex.value, onItemTapped : (index) => itemController.onItemTapped(index)),
    ); 
  }
  
}
