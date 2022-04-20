part of 'january_cubit.dart';

@immutable
class JanuaryState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;


  const JanuaryState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,

  });
}
