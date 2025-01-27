import 'package:flutter/material.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesabım'),
        centerTitle: true,
      ),
      body:  Center(
        child: TextButton(onPressed: (){
          firestoreService.logoutUser();
        }, child: Text('çıkış')),
      ),
    );
  }
}