import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/item_model.dart';
import 'package:thankfulness/repositories/august_repositories.dart';

part 'august_state.dart';

class AugustCubit extends Cubit<AugustState> {
  AugustCubit(this._augustRepositories)
      : super(
          const AugustState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final AugustRepositories _augustRepositories;

  Future<void> start() async {
    const AugustState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _augustRepositories.getItemsStream().listen(
      (data) {
        emit(
          AugustState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          AugustState(
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
    await _augustRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _augustRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
