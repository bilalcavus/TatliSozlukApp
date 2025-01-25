import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference titles =
    FirebaseFirestore.instance.collection('titles');
      Stream<QuerySnapshot> getTitles() {
      final titlesStream = titles.orderBy('timestamp', descending: true).snapshots();
      return titlesStream;
    }
    Future<void> addTitle(String title) async {
      titles.add({
        'title': title,
        'timestamp': Timestamp.now(),
        });

  
  }
}
