import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:thankfulness/repositories/april_repositories.dart';
import '../../item/item_model.dart';
part 'month_state.dart';

class MonthCubit extends Cubit<MonthState> {
  MonthCubit(this._aprilRepositories)
      : super(
          const MonthState(
            errorMessage: '',
            isLoadiing: false,
            count: [],
          ),
        );

  StreamSubscription? _streamSubscription;
  final AprilRepositories _aprilRepositories;

  Future<void> start() async {
    const MonthState(
      errorMessage: '',
      isLoadiing: true,
      count: [],
    );

    _streamSubscription = _aprilRepositories.getItemsStream().listen(
      (data) {
        emit(
          MonthState(
            errorMessage: '',
            isLoadiing: false,
            count: data,
          ),
        );
      },
    )..onError(
        (error) {
          MonthState(
            errorMessage: error.toString(),
            isLoadiing: false,
            count: const [],
          );
        },
      );
  }

  Future<int?> getCount() async {
    FirebaseFirestore.instance.collection('april').snapshots();
    return null;
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
