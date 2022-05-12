import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/goals_repositories.dart';

part 'goals_counter_state.dart';

class GoalsCounterCubit extends Cubit<GoalsCounterState> {
  GoalsCounterCubit(this._goalsRepositories)
      : super(
          const GoalsCounterState(
            errorMessage: '',
            isLoadiing: false,
            count: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final GoalsRepositories _goalsRepositories;

  Future<void> start() async {
    const GoalsCounterState(
      errorMessage: '',
      isLoadiing: true,
      count: [],
    );

    _streamSubscription = _goalsRepositories.getItemsStream().listen(
      (data) {
        emit(
          GoalsCounterState(
            errorMessage: '',
            isLoadiing: false,
            count: data,
          ),
        );
      },
    )..onError(
        (error) {
          GoalsCounterState(
            errorMessage: error.toString(),
            isLoadiing: false,
            count: const [],
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
