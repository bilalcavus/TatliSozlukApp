// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/constants/text_styles.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;



  Future<void> signUp() async {
    if (passwordConfirmed()) {
        _firestoreService.signUp(_emailController, _passwordController);
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
          'userId': user!.uid,
        });
    }
  }
  
  bool passwordConfirmed() {
    return _passwordController.text.trim() == _confirmPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo_sozluk.png',height: 250,),
              buildTextField(_firstNameController, 'ad', false),
              SizedBox(height: 10),
              buildTextField(_lastNameController, 'soyad', false),
              SizedBox(height: 10),
              buildTextField(_emailController, 'email', false),
              SizedBox(height: 10),
              buildTextField(_passwordController, 'şifre', true),
              SizedBox(height: 10),
              buildTextField(_confirmPasswordController, 'şifreyi onayla', true),
              SizedBox(height: 20),
              // Register Button
              registerButton(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TextStrings.alreadyHasAccountText, style: TextStyles().alreadyHasAccount),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(TextStrings.loginbtnText, style: TextStyles().loginStringTextStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding registerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: signUp,
          child: Container(
            padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 128, 86, 83),
                  borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(TextStrings.registerbtnText, style: TextStyles().registerButtonStyle),
                  ),
                ),
              ),
            );
  }

  EdgeInsets textFieldPadding = EdgeInsets.symmetric(horizontal: 25.0);
  Widget buildTextField(TextEditingController controller, String hintText, bool isSecure) {
  return Padding(
    padding: textFieldPadding,
    child: customTextField(controller, hintText, isSecure),
  );
}
  TextField customTextField(controller, String hintText, bool isSecure) {
    return TextField(
      controller: controller,
      obscureText: isSecure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: false,
        fillColor: Colors.grey[200]));
      }
    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}

