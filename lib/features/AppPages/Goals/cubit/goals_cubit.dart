import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/goals_repositories.dart';

part 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit(this._goalsRepositories)
      : super(
          const GoalsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  final GoalsRepositories _goalsRepositories;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const GoalsState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = _goalsRepositories.getItemsStream().listen(
      (data) {
        emit(
          GoalsState(
            documents: data,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError(
        (error) {
          GoalsState(
            documents: const [],
            isLoading: false,
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
    required name,
  }) async {
    _goalsRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
