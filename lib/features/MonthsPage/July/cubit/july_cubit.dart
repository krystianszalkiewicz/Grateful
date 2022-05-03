import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/models/Widgets/item/item_model.dart';
import 'package:thankfulness/repositories/july_repositories.dart';

part 'july_state.dart';

class JulyCubit extends Cubit<JulyState> {
  JulyCubit(this._julyRepositories)
      : super(
          const JulyState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final JulyRepositories _julyRepositories;

  Future<void> start() async {
    const JulyState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _julyRepositories.getItemsStream().listen(
      (data) {
        emit(
          JulyState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          JulyState(
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
    await _julyRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _julyRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
