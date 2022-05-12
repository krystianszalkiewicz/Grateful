import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/goals_repositories.dart';

import '../../../../App/core/enums.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit(this._goalsRepositories)
      : super(
          const GoalsState(
            documents: [],
            errorMessage: '',
            status: Status.initial,
          ),
        );
  final GoalsRepositories _goalsRepositories;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const GoalsState(
        documents: [],
        status: Status.loading,
        errorMessage: '',
      ),
    );

    _streamSubscription = _goalsRepositories.getItemsStream().listen(
      (data) {
        emit(
          GoalsState(
            documents: data,
            status: Status.success,
            errorMessage: '',
          ),
        );
      },
    )..onError(
        (error) {
          GoalsState(
            documents: const [],
            status: Status.error,
            errorMessage: error.toString(),
          );
        },
      );
  }

  Future<void> delete({
    required document,
    required id,
  }) async {
    await _goalsRepositories.delete(id: document.id);
  }

  Future<void> add({
    required String name,
  }) async {
    _goalsRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
