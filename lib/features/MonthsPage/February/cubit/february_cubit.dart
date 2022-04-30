import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/item_model.dart';
import 'package:thankfulness/repositories/february_repositories.dart';


part 'february_state.dart';

class FebruaryCubit extends Cubit<FebruaryState> {
  FebruaryCubit(this._februaryRepositories)
      : super(
          const FebruaryState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  final FebruaryRepositories _februaryRepositories;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const FebruaryState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = _februaryRepositories.getItemsStream().listen(
      (data) {
        emit(
          FebruaryState(
            documents: data,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError(
        (error) {
          FebruaryState(
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
    await _februaryRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _februaryRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
