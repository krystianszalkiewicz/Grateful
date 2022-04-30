part of 'september_cubit.dart';

@immutable
class SeptemberState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const SeptemberState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
