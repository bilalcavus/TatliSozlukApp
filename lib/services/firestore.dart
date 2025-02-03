import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference titles = FirebaseFirestore.instance.collection('titles');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  DateTime now = DateTime.now();
  DateTime startOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime endOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);


  Future<Map<String, dynamic>?> getUserEntries() async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('entries')
        .doc(userId)
        .get();

    if (!userDoc.exists) return null;
    return userDoc.data() as Map<String, dynamic>;
  } catch (e) {
    print("Hata: $e");
    return null;
  }
}

  Future<void> signUp(email, password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
  }

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

  Stream<DocumentSnapshot> getUserData(String uid) {
    return _db.collection('users').doc(uid).snapshots();
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

  Future<DocumentSnapshot> getUserDataById(String userId) async {
    return await _db.collection('users').doc(userId).get();
  }
}
