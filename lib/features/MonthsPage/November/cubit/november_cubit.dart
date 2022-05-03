import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/november_repositories.dart';

part 'november_state.dart';

class NovemberCubit extends Cubit<NovemberState> {
  NovemberCubit(this._novemberRepositories)
      : super(
          const NovemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final NovemberRepositories _novemberRepositories;

  Future<void> start() async {
    const NovemberState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _novemberRepositories.getItemsStream().listen(
      (data) {
        emit(
          NovemberState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          NovemberState(
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
    await _novemberRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _novemberRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
