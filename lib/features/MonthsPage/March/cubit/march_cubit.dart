import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/item_model.dart';
import 'package:thankfulness/repositories/item_repositories.dart';

part 'march_state.dart';

class MarchCubit extends Cubit<MarchState> {
  MarchCubit(this._marchRepositories)
      : super(
          const MarchState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final MarchRepositories _marchRepositories;
  Future<void> start() async {
    const MarchState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _marchRepositories.getItemsStream().listen(
      (data) {
        emit(
          MarchState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          MarchState(
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
    await _marchRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _marchRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
