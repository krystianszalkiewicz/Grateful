part of 'golas_cpunter_cubit.dart';

@immutable
class GoalsCounterState {
  final List<ItemModel> count;
  final String? errorMessage;
  final Status status;

  const GoalsCounterState({
    required this.count,
    required this.errorMessage,
    this.status = Status.initial,
  });
}
