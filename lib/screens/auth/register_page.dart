// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim());
    }
  }

  bool passwordConfirmed(){
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      return true;
    }
    else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.grey[200],
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
              SizedBox(height: 10,),
              //confirm password
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
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
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
                  onTap:  signUp,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(color:Color.fromARGB(255, 128, 86, 83),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child:  Center(
                      child: Text('kayıt ol',
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
                  Text('zaten kayıt oldum!  ', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      'giriş yap',
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