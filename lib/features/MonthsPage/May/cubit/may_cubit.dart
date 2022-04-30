import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:thankfulness/models/item_model.dart';
import '../../../../repositories/may_repositories.dart';
part 'may_state.dart';

class MayCubit extends Cubit<MayState> {
  MayCubit(this._mayRepositories)
      : super(
          const MayState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final MayRepositories _mayRepositories;

  Future<void> start() async {
    const MayState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _mayRepositories.getItemsStream().listen(
      (data) {
        emit(
          MayState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          MayState(
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
    await _mayRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _mayRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
