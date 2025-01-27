import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        if (_isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        }
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/homePage');
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Bir hata oluştu';
        if (_isLogin) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
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
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen şifrenizi girin';
              }
              if (!_isLogin && value.length < 6) {
                return 'Şifre en az 6 karakter olmalıdır';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(_isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: Text(_isLogin
                ? 'Hesabınız yok mu? Kayıt olun'
                : 'Zaten hesabınız var mı? Giriş yapın'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
