import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/repositories/january_repositories.dart';


import '../../../../models/Widgets/item/item_model.dart';

part 'january_state.dart';

class JanuaryCubit extends Cubit<JanuaryState> {
  JanuaryCubit(this._itemRepositories)
      : super(
          const JanuaryState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final JanuaryRepositories _itemRepositories;
  StreamSubscription? _streamSubscription;

  

  Future<void> start() async {
    emit(
      const JanuaryState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );
    _streamSubscription = _itemRepositories.getItemsStream().listen(
      (data) {
        emit(
          JanuaryState(
            documents: data,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError(
        (error) {
          JanuaryState(
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
    await _itemRepositories.delete(id: document.id);
  }

  Future<void> add({
    required String name,
  }) async {
    _itemRepositories.add(name: name);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
