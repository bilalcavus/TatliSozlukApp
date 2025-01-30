// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/screens/auth/auth_page.dart';
import 'package:tatli_sozluk/screens/auth/login_page.dart';
import 'package:tatli_sozluk/screens/profile_view.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) return const ProfileView();
          else return const AuthPage();
        },),
    );
  }
}