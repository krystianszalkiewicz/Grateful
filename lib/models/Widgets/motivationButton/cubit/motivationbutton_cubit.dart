import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/App/core/enums.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import '../../../../repositories/motivation_repositories.dart';
part 'motivationbutton_state.dart';

class MotivationbuttonCubit extends Cubit<MotivationbuttonState> {
  MotivationbuttonCubit(this._motivationRepositories)
      : super(
          const MotivationbuttonState(
            documents: [],
            errorMessage: '',
            status: Status.initial,
          ),
        );
  StreamSubscription? _streamSubscription;
  final MotivationRepositories _motivationRepositories;

  Future<void> start() async {
    const MotivationbuttonState(
      errorMessage: '',
      status: Status.loading,
      documents: [],
    );

    _streamSubscription = _motivationRepositories.getItemsStream().listen(
      (data) {
        emit(
          MotivationbuttonState(
            errorMessage: '',
            status: Status.success,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          MotivationbuttonState(
            errorMessage: error.toString(),
            status: Status.error,
            documents: const [],
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
