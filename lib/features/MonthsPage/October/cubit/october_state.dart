part of 'october_cubit.dart';

@immutable
class OctoberState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const OctoberState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
