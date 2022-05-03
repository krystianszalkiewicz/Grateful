import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/repositories/june_repositories.dart';

import '../../../../models/Widgets/item/item_model.dart';
part 'june_state.dart';

class JuneCubit extends Cubit<JuneState> {
  JuneCubit(this._juneRepositories)
      : super(
          const JuneState(
            errorMessage: '',
            isLoadiing: false,
            documents: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final JuneRepositories _juneRepositories;

  Future<void> start() async {
    const JuneState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );

    _streamSubscription = _juneRepositories.getItemsStream().listen(
      (data) {
        emit(
          JuneState(
            errorMessage: '',
            isLoadiing: false,
            documents: data,
          ),
        );
      },
    )..onError(
        (error) {
          JuneState(
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
    await _juneRepositories.delete(id: document.id);
  }

  Future<void> add({
    required name,
  }) async {
    _juneRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
