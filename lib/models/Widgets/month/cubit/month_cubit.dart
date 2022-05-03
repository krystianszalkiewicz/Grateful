import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meta/meta.dart';

import '../../item/item_model.dart';

part 'month_state.dart';

class MonthCubit extends Cubit<MonthState> {
  MonthCubit()
      : super(
          const MonthState(
            documents: [],
            errorMessage: '',
            isLoadiing: false,
          ),
        );

  Future<void> start() async {
    const MonthState(
      errorMessage: '',
      isLoadiing: true,
      documents: [],
    );
  }

  Future<void> getCount(int length, List document) async {
    await FirebaseFirestore.instance.collection('april').get().then((value) {
      var count = 0;
      count = value.docs.length;
      return count;
    });
  }
}
