part of 'july_cubit.dart';

@immutable
 class JulyState {
   final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const JulyState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
 }

