// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 10,),
          
              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Padding(
                    padding:  EdgeInsets.only(left: 20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              //sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap:  signIn,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(color: Color.fromARGB(255, 128, 86, 83),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child:  Center(
                      child: Text('giriş yap',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                      fontSize: 18),),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25,),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('üye olmadın mı? ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    
                  ),),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      'kayıt ol',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}