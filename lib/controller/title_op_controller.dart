import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class TitleOpController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
}