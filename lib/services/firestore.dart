import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference titles =
      FirebaseFirestore.instance.collection('titles');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();
  DateTime startOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day); // 00:00
  DateTime endOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59); // 23:59:59


  Future<void> addEntry(String titleId, String entryText) async {
    final entryCollection = titles.doc(titleId).collection('entries');
    await entryCollection.add({
      'entryContext': entryText,
      'timestamp': Timestamp.now(),
      'userId': _auth.currentUser?.uid,
    });
  }

  Stream<QuerySnapshot> getEntries(String titleId) {
    final entriesStream = titles
        .doc(titleId)
        .collection('entries')
        .orderBy('timestamp', descending: false)
        .snapshots();
    return entriesStream;
  }

  Stream<QuerySnapshot> getTodayEntries(String titleId) {
    final entriesStream = titles
        .doc(titleId)
        .collection('entries')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('timestamp', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('timestamp', descending: true)
        .snapshots();
    return entriesStream;
  }

  Stream<QuerySnapshot> getTitles() {
    final titlesStream =
        titles.orderBy('timestamp', descending: true).snapshots();
    return titlesStream;
  }

  Future<void> addTitle(String title) async {
    titles.add({
      'title': title,
      'timestamp': Timestamp.now(),
      'userId': _auth.currentUser?.uid,
    });
  }

  Future<void> deleteTitle(String docID) async {
    titles.doc(docID).delete();
  }

  Future<void> deleteEntry(String titleId, String entryId) async {
    final entryCollection = titles.doc(titleId).collection('entries');
    await entryCollection.doc(entryId).delete();
  }

  Future<QuerySnapshot<Object?>> searchTitle(String query) async {
    final searchResults = await titles
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    return searchResults;
  }

  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      print('Kullanıcı kaydı sırasında hata: $e');
      rethrow;
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      print('Kullanıcı girişi sırasında hata: $e');
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
