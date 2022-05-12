import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/App/core/enums.dart';
import 'package:thankfulness/repositories/grateful_repositories.dart';
import '../../../../models/Widgets/item/item_model.dart';

part 'grateful_state.dart';

class GratefulCubit extends Cubit<GratefulState> {
  GratefulCubit(this._itemRepositories)
      : super(
          const GratefulState(
              documents: [], errorMessage: '', status: Status.initial),
        );
  StreamSubscription? _streamSubscription;
  final GratefulRepositories _itemRepositories;

  Future<void> start() async {
    emit(
      const GratefulState(
        documents: [],
        errorMessage: '',
        status: Status.loading,
      ),
    );
    _streamSubscription = _itemRepositories.getItemsStream().listen(
      (data) {
        emit(
          GratefulState(
            documents: data,
            status: Status.success,
            errorMessage: '',
          ),
        );
      },
    )..onError(
        (error) {
          GratefulState(
            documents: const [],
            status: Status.error,
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
