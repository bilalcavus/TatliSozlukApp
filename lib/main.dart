import 'package:flutter/material.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/homePage': (context) => const HomePageView(),
        '/searchPage': (context) => const HomePageView(),
        '/notificationPage': (context) => const HomePageView(),
        '/profilePage': (context) => const HomePageView(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageView(),
    );
  }
}