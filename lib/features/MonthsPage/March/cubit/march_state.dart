part of 'march_cubit.dart';

@immutable
class MarchState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final String errorMessage;
  final bool isLoadiing;

  const MarchState(
      {required this.documents,
      required this.errorMessage,
      required this.isLoadiing});
}
