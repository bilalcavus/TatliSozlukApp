import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/components/custom_bottom_navbar.dart';
import 'package:tatli_sozluk/components/custom_buttons.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';
import 'package:tatli_sozluk/screens/add_entry_view.dart';
import 'package:tatli_sozluk/services/firestore.dart';
import 'package:tatli_sozluk/widgets/entryList_stream_widget.dart';

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
    String docID = args?['docID'] ?? '';
    String titleText = args?['titleText'] ?? '';
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.scrim,
        title: Text(titleText),
        centerTitle: true,
        actions: [
          appBarIcons(context, docID, titleText)
        ]),
      body: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton().notificationButton,
                CustomIconButton().sortButton,
                CustomIconButton().searchButton,
                CustomIconButton().shareButton
              ]),
        Expanded(
            child: EntryListStream(firestoreService: firestoreService, docID: docID),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: itemController.selectedIndex.value, 
        onItemTapped : (index) => itemController.onItemTapped(index)),
    );
  }

IconButton appBarIcons(BuildContext context, String docID, String titleText) {
  return IconButton(
    icon: const Icon(Iconsax.pen_add5) ,
    onPressed: (){
      if (user == null) Navigator.pushReplacementNamed(context, '/loginPage');
      else{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const AddEntryView(),
          settings: RouteSettings(
          arguments: {
            'docID': docID,
            'titleText': titleText,
            })),
          );
        }
      },
    );
  }
}

