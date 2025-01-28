import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatli_sozluk/services/firestore.dart';
import 'package:tatli_sozluk/controller/bottom_navigation_controller.dart';

class TitleOpController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
}