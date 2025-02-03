// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/components/custom_colors.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/constants/text_styles.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo_sozluk.png', height: 250),
              buildTextField(_emailController,'email', false),
              const SizedBox(height: 10),
              buildTextField(_passwordController, 'şifre', true),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap:  signIn,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(color: CustomColors().boxDecoration, borderRadius: BorderRadius.circular(12)),
                    child:  Center(child: Text(TextStrings.loginbtnText, style: TextStyles().loginbuttonStyle),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TextStrings.notAlreadyLoginText, style: TextStyles().notAlreadyLogin),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(TextStrings.registerbtnText, style: TextStyles().loginStringTextStyle),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  EdgeInsets textFieldPadding = EdgeInsets.symmetric(horizontal: 25.0);
  Widget buildTextField(TextEditingController controller, String hintText,bool isSecure) {
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
}