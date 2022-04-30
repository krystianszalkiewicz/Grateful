import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:thankfulness/repositories/april_repositories.dart';
import 'april_state.dart';



class AprilCubit extends Cubit<AprilState> {
  AprilCubit(this._aprilRepositories)
      : super(
          const AprilState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final AprilRepositories _aprilRepositories;
  Future<void> start() async {
    const AprilState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _aprilRepositories.getItemsStream().listen(
      (data) {
        emit(
          AprilState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          AprilState(
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
    await _aprilRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _aprilRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
