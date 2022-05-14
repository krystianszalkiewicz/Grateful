part of 'golas_counter_cubit.dart';

@immutable
class GoalsCounterState {
  const GoalsCounterState({
    required this.count,
    required this.errorMessage,
    this.status = Status.initial,
  });
  final List<ItemModel> count;
  final String? errorMessage;
  final Status status;
}
