// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class EntryListStream extends StatelessWidget {
  EntryListStream({
    super.key,
    required this.firestoreService,
    required this.docID,
  });

  final FirestoreService firestoreService;
  final String docID;
  final user = FirebaseAuth.instance.currentUser;

  Widget _buildUserInfo(Map<String, dynamic> entryData) {
    return FutureBuilder(
      future: firestoreService.getUserDataById(entryData['userId']),
      builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.hasError) return const Text('Hata oluştu');
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(width: 20, height: 20,child: CircularProgressIndicator(strokeWidth: 2));
          }
        if (!userSnapshot.hasData || !userSnapshot.data!.exists) return const Text('Kullanıcı bulunamadı');
        Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
        String firstName = userData['first_name'] ?? '';
        String lastName = userData['last_name'] ?? '';
        
        return Text(
          '$firstName $lastName',
          style: const TextStyle(
            fontSize: 15,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getEntries(docID),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text(TextStrings.errorMessage);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List entriesList = snapshot.data!.docs;
        return ListView.builder(
          itemCount: entriesList.length,
          itemBuilder:(context, index) {
            Map<String, dynamic> data = entriesList[index].data() as Map<String, dynamic>;
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  title: Text(
                    data['entryContext'], 
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.zero,
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          height: 35,
                          onTap: () {
                            firestoreService.deleteEntry(docID, entriesList[index].id);
                          },
                          child: const Icon(Icons.highlight_remove_sharp)
                        )
                      ]
                    )
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildUserInfo(data),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      foregroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                      backgroundColor: Colors.black87)
                  ],
                )
              ]
            );
          }
        );
      }
    );
  }
}
