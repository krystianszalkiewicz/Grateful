import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoalsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getGoalsData() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      Exception('Jesteś nie zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('goals')
        .snapshots();
  }
}
