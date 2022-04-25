import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'march_state.dart';

class MarchCubit extends Cubit<MarchState> {
  MarchCubit()
      : super(
          const MarchState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    const MarchState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription =
        FirebaseFirestore.instance.collection('march').snapshots().listen(
      (data) {
        emit(
          MarchState(
            errorMessage: '',
            isLoadiing: false,
            documents: data.docs,
          ),
        );
      },
    )..onError(
            (error) {
              MarchState(
                errorMessage: error.toString(),
                isLoadiing: false,
                documents: const [],
              );
            },
          );
  }

  Future<void> delete({
    required document,
    required id,
  }) async {
    FirebaseFirestore.instance.collection('february').doc(document.id).delete();
  }

  Future<void> add({
    required name,
  }) async {
    FirebaseFirestore.instance.collection('february').add(
      {
        'name': name,
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
