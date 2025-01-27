// lib/controllers/user_login_controller.dart

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class UserLoginController extends GetxController {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoading = false.obs;
  var _isLogin = true.obs;
  final FirestoreService _firestoreService = FirestoreService();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  RxBool get isLoading => _isLoading;
  RxBool get isLogin => _isLogin;

  Future<void> submitForm() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    _isLoading.value = true;

    try {
      if (_isLogin.value) {
        User? user = await _firestoreService.loginUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          Get.offAllNamed('/homePage');
        }
      } else {
        User? user = await _firestoreService.registerUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          Get.offAllNamed('/homePage');
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Bir hata oluştu';
      if (_isLogin.value) {
        if (e.code == 'user-not-found') {
          message = 'Bu email için kullanıcı bulunamadı';
        } else if (e.code == 'wrong-password') {
          message = 'Yanlış şifre';
        }
      } else {
        if (e.code == 'weak-password') {
          message = 'Şifre çok zayıf';
        } else if (e.code == 'email-already-in-use') {
          message = 'Bu email adresi zaten kullanımda';
        }
      }
      Get.snackbar('Hata', message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  void toggleLoginState() {
    _isLogin.value = !_isLogin.value;
  }

  @override
  void onClose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.onClose();
  }
}
