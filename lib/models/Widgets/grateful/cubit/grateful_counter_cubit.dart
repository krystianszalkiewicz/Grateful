import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/repositories/grateful_repositories.dart';
import '../../item/item_model.dart';
part 'grateful_counter_state.dart';

class GratefulCounterCubit extends Cubit<GratefulCounterState> {
  GratefulCounterCubit(this._gratefulRepositories)
      : super(
          const GratefulCounterState(
            errorMessage: '',
            isLoadiing: false,
            count: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final GratefulRepositories _gratefulRepositories;

  Future<void> start() async {
    const GratefulCounterState(
      errorMessage: '',
      isLoadiing: true,
      count: [],
    );

    _streamSubscription = _gratefulRepositories.getItemsStream().listen(
      (data) {
        emit(
          GratefulCounterState(
            errorMessage: '',
            isLoadiing: false,
            count: data,
          ),
        );
      },
    )..onError(
        (error) {
          GratefulCounterState(
            errorMessage: error.toString(),
            isLoadiing: false,
            count: const [],
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
