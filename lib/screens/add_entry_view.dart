import 'package:flutter/material.dart';
import 'package:tatli_sozluk/services/firestore.dart';

class AddEntryView extends StatefulWidget {
  const AddEntryView({super.key});

  @override
  State<AddEntryView> createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
    final TextEditingController textEditingController = TextEditingController();
    final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String docID = args?['docID'] ?? 'docID bulunamadi';
    String titleText = args?['titleText'] ?? 'baslik bulunamadi';
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
              firestoreService.addEntry(docID, textEditingController.text);
              textEditingController.clear();
              Navigator.of(context).pop();
          }, child: const Text('Ekle') )
        ],
      ),
      body: Column(
        children: [
          Text(titleText),
          TextField(
            controller: textEditingController,
          ),
        ],
      ),
    );
  }
}