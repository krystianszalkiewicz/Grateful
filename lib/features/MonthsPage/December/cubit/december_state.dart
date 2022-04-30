part of 'december_cubit.dart';

@immutable
class DecemberState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const DecemberState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
