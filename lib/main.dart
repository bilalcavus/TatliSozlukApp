import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/controller/auth_controller.dart';
import 'package:tatli_sozluk/firebase_options.dart';
import 'package:tatli_sozluk/screens/auth/login_page.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';
import 'package:tatli_sozluk/screens/notifications_view.dart';
import 'package:tatli_sozluk/screens/search_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/homePage': (context) => const HomePageView(),
        '/searchPage': (context) => const SearchPageView(),
        '/notificationPage': (context) => const NotificationsView(),
        '/profilePage': (context) => const AccountPageView(),
        '/loginPage': (context) =>  LoginPage(showRegisterPage: () {})
      },
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const HomePageView(),
    );
  }
}