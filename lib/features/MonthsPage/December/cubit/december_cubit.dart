import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/item_model.dart';
import 'package:thankfulness/repositories/december_repositories.dart';

part 'december_state.dart';

class DecemberCubit extends Cubit<DecemberState> {
  DecemberCubit(this._decemberRepositories)
      : super(
          const DecemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final DecemberRepositories _decemberRepositories;

  Future<void> start() async {
    const DecemberState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _decemberRepositories.getItemsStream().listen(
      (data) {
        emit(
          DecemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          DecemberState(
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
    await _decemberRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _decemberRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
