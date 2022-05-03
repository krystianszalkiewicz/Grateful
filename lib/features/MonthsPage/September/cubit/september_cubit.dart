import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/september_repositories.dart';

part 'september_state.dart';

class SeptemberCubit extends Cubit<SeptemberState> {
  SeptemberCubit(this._septemberRepositories)
      : super(
          const SeptemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final SeptemberRepositories _septemberRepositories;

  Future<void> start() async {
    const SeptemberState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _septemberRepositories.getItemsStream().listen(
      (data) {
        emit(
          SeptemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          SeptemberState(
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
    await _septemberRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _septemberRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
