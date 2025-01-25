import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
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
    final DeleteEntryService deleteEntryService = DeleteEntryService();

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
            icon: Icon(Icons.post_add_rounded) ,
            onPressed: (){
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
            },
            )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.notification_important_outlined)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.more_time_sharp)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.search_sharp)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.ios_share_sharp)),
                    ],
                  ),
                  ListTile(
                    title: Text(data['entryContext']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteEntryService.deleteEntry(docID, entriesList[index].id);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                  child: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.favorite_border_rounded),)))
                    
                ],
              );
            }
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: itemController.selectedIndex.value, onItemTapped : (index) => itemController.onItemTapped(index)),
    ); 
  }
  
}
