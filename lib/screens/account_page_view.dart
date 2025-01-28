import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  FirestoreService firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesabım'),
        centerTitle: true,
      ),
      body: user == null
          ? Column(
              children: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/authPage');
                    },
                    child: const Text('Henüz giriş yapmadınız. Giriş yapmak için tıklayın'),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Center(
                  child: Text('Hoşgeldiniz, ${user?.email ?? "Kullanıcı"}!'),
                ),
                TextButton(
                  onPressed:  () async {
                  await firestoreService.logoutUser();
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const HomePageView()));
                  
                }, child: const Text('çıkış yap'))
              ],
            ),
    );
  }
}
