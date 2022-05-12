

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';

class MotivationRepositories {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance.collection('motivation').snapshots().map(
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


  
}
