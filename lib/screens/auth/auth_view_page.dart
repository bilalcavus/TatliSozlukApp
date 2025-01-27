// lib/screens/user_login_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatli_sozluk/controller/user_login_controller.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserLoginController controller = Get.put(UserLoginController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.isLogin.value ? 'Giriş Yap' : 'Kayıt Ol')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen email adresinizi girin';
                  }
                  if (!value.contains('@')) {
                    return 'Lütfen geçerli bir email adresi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  }
                  if (!controller.isLogin.value && value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.submitForm,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text(controller.isLogin.value ? 'Giriş Yap' : 'Kayıt Ol'),
                )),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  controller.toggleLoginState();
                },
                child: Obx(() => Text(controller.isLogin.value
                    ? 'Hesabınız yok mu? Kayıt olun'
                    : 'Zaten hesabınız var mı? Giriş yapın')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
