import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/firebase_options.dart';
import 'package:tatli_sozluk/screens/home_page_view.dart';
import 'package:tatli_sozluk/screens/title_view_page.dart';

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
        '/searchPage': (context) => const HomePageView(),
        '/notificationPage': (context) => const HomePageView(),
        '/profilePage': (context) => const HomePageView(),
      },
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const TitleViewPage(),
    );
  }
}