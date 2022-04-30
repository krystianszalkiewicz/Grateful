part of 'august_cubit.dart';

@immutable
class AugustState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const AugustState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
