part of 'november_cubit.dart';

@immutable
class NovemberState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const NovemberState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
