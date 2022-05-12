import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import '../../../../repositories/motivation_repositories.dart';
part 'motivationbutton_state.dart';

class MotivationbuttonCubit extends Cubit<MotivationbuttonState> {
  MotivationbuttonCubit(this._motivationRepositories)
      : super(
          const MotivationbuttonState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  final MotivationRepositories _motivationRepositories;

  Future<void> start() async {
    const MotivationbuttonState(
      errorMessage: '',
      isLoading: true,
      documents: [],
    );

    _streamSubscription = _motivationRepositories.getItemsStream().listen(
      (data) {
        emit(
          MotivationbuttonState(
            errorMessage: '',
            isLoading: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          MotivationbuttonState(
            errorMessage: error.toString(),
            isLoading: false,
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
