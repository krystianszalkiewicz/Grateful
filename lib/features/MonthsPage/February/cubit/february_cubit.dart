import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'february_state.dart';

class FebruaryCubit extends Cubit<FebruaryState> {
  FebruaryCubit()
      : super(
          const FebruaryState(
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

  Future<void> start() async {
    emit(
      const FebruaryState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription =
        FirebaseFirestore.instance.collection('february').snapshots().listen(
      (data) {
        emit(
          FebruaryState(
            documents: data.docs,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError(
            (error) {
              FebruaryState(
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
