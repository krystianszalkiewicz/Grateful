part of 'goals_cubit.dart';

@immutable
class GoalsState {
  final List<ItemModel> documents;
  final String? errorMessage;
  final Status status;

  const GoalsState({
    required this.errorMessage,
    required this.documents,
    this.status = Status.initial,
  });
}
