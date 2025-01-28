import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class EntryListStream extends StatelessWidget {
  const EntryListStream({
    super.key,
    required this.firestoreService,
    required this.docID,
  });

  final FirestoreService firestoreService;
  final String docID;

  @override
  Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: firestoreService.getEntries(docID),
    builder: (context, snapshot) {
      if (snapshot.hasError) return const Text(TextStrings.errorMessage);
      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
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
                  child: const Icon(Icons.highlight_remove_sharp))];
                  }))),
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
                    CircleAvatar(backgroundColor: Colors.black87,)
          ])],
        )]);
      });
    });
  }}
