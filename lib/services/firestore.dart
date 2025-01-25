import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference titles =
    FirebaseFirestore.instance.collection('titles');

Future<void> addEntry (String titleId, String entryText) async {
      final entryCollection = titles.doc(titleId).collection('entries');
      await entryCollection.add( {
        'entryContext': entryText,
        'timestamp': Timestamp.now(),
      });
    }
      Stream<QuerySnapshot> getEntries(String titleId) {
      final entriesStream = titles.doc(titleId).collection('entries').orderBy('timestamp', descending: true).snapshots();
      return entriesStream;
    }
      Stream<QuerySnapshot> getTitles() {
      final titlesStream = titles.orderBy('timestamp', descending: true).snapshots();
      return titlesStream;
    }
    Future<void> addTitle(String title) async {
      titles.add({
        'title': title,
        'timestamp': Timestamp.now(),
        });
    Future<void> deleteTitle(String docID) async {
      titles.doc(docID).delete();
    }
    
    }
}

class DeleteEntryService {
  final CollectionReference titles =
    FirebaseFirestore.instance.collection('titles');
  Future<void> deleteEntry(String titleId, String entryId) async {
    final entryCollection = titles.doc(titleId).collection('entries');
    await entryCollection.doc(entryId).delete();
  }
  
}