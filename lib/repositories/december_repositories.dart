import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';

class DecemberRepositories {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance.collection('december').snapshots().map(
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
    return FirebaseFirestore.instance.collection('december').doc(id).delete();
  }

  Future<void> add({required String name}) {
    return FirebaseFirestore.instance
        .collection('december')
        .add({'name': name});
  }
}
