import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tatli_sozluk/constants/text_strings.dart';
import 'package:tatli_sozluk/controller/title_op_controller.dart';
import 'package:tatli_sozluk/screens/title_view_page.dart';

class StreamBuilderContent extends StatelessWidget {
  const StreamBuilderContent({
    super.key,
    required this.controller,
  });

  final TitleOpController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
    stream: controller.firestoreService.getTitles(),
    builder: (context,snapshot){
      if (snapshot.hasData) {
        List titlesList = snapshot.data!.docs;
        return ListView.builder(
        itemCount: titlesList.length,
        itemBuilder: (context,index){
          DocumentSnapshot document = titlesList[index];
          String docID = document.id;
          Map<String,dynamic> data = document.data() as Map<String,dynamic>;
          String titleText = data['title'];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const TitleViewPage(),
                settings: RouteSettings(arguments: {'docID': docID, 'titleText': titleText} )));
            },
            title: Text(titleText, style : const TextStyle(fontSize: 14)),
          );
        });
      }
      else {
        return  const Text(TextStrings.noData);
      }
    }
    );
  }
}
