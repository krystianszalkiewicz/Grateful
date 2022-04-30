import 'package:flutter/material.dart';
import 'package:thankfulness/models/item_model.dart';



@immutable
class AprilState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const AprilState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
