import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thankfulness/data/remote_data_sources/goals_remote_data_sources.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';

class GoalsRepositories {
  final GoalsRemoteDataSource _goalsRemoteDataSource;
  GoalsRepositories(this._goalsRemoteDataSource);

  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      Exception('Jesteś nie zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('goals')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return ItemModel(
            name: doc['name'],
            id: doc.id,
          );
        }).toList();
      },
    );
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      Exception('Jesteś nie zalogowany');
    }
    return _goalsRemoteDataSource.delete(id: '');
  }

  Future<void> add({required String name}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      Exception('Jesteś nie zalogowany');
    }
    return _goalsRemoteDataSource.add(name: '');
  }

  Future<int?> getCount() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      Exception('Jesteś nie zalogowany');
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('goals')
        .snapshots();
    return null;
  }
}
