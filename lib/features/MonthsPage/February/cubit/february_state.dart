// ignore_for_file: prefer_typing_uninitialized_variables

part of 'february_cubit.dart';

@immutable
class FebruaryState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;

  final errorMessage;

  const FebruaryState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
