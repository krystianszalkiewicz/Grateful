part of 'may_cubit.dart';


@immutable
 class MayState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const MayState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
