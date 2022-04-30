part of 'june_cubit.dart';

@immutable
class JuneState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const JuneState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
