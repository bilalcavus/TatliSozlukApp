import 'package:flutter/material.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesabım'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Hesabım Sayfası'),
      ),
    );
  }
}