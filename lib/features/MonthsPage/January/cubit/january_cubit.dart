import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/item_model.dart';

part 'january_state.dart';

class JanuaryCubit extends Cubit<JanuaryState> {
  JanuaryCubit()
      : super(
          const JanuaryState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> delete({
    required document,
    required id,
  }) async {
    FirebaseFirestore.instance.collection('january').doc(document.id).delete();
  }

  Future<void> add({
    required String name,
  }) async {
    FirebaseFirestore.instance.collection('january').add({'name': name});
  }

  Future<void> start() async {
    emit(
      const JanuaryState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    _streamSubscription =
        FirebaseFirestore.instance.collection('january').snapshots().listen(
      (data) {
        final itemModels = data.docs.map((doc) {
          return ItemModel(
            name: doc['name'],
            id: doc.id,
          );
        }).toList();
        emit(
          JanuaryState(
            documents: itemModels,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError(
            (error) {
              JanuaryState(
                documents: const [],
                isLoading: false,
                errorMessage: error.toString(),
              );
            },
          );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
