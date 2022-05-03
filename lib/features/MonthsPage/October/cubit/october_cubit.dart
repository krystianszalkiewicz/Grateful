import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/october_repositories.dart';

part 'october_state.dart';

class OctoberCubit extends Cubit<OctoberState> {
  OctoberCubit(this._octoberRepositories)
      : super(
          const OctoberState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final OctoberRepositories _octoberRepositories;

  Future<void> start() async {
    const OctoberState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _octoberRepositories.getItemsStream().listen(
      (data) {
        emit(
          OctoberState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          OctoberState(
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
    await _octoberRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _octoberRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
