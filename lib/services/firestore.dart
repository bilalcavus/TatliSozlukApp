import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference titles =
      FirebaseFirestore.instance.collection('titles');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Title ve Entry İşlemleri
  Future<void> addEntry(String titleId, String entryText) async {
    final entryCollection = titles.doc(titleId).collection('entries');
    await entryCollection.add({
      'entryContext': entryText,
      'timestamp': Timestamp.now(),
      'userId': _auth.currentUser?.uid, // Kullanıcı ID'si kaydediliyor
    });
  }

  Stream<QuerySnapshot> getEntries(String titleId) {
    final entriesStream = titles
        .doc(titleId)
        .collection('entries')
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
      'userId': _auth.currentUser?.uid, // Kullanıcı ID'si kaydediliyor
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

  // Kullanıcı Kayıt ve Giriş İşlemleri
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
