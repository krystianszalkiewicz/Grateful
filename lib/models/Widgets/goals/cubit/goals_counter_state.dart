part of 'golas_cpunter_cubit.dart';

@immutable
class GoalsCounterState {
  const GoalsCounterState({
    required this.count,
    required this.errorMessage,
    required this.isLoadiing,
  });

  final List<ItemModel> count;
  final String errorMessage;
  final bool isLoadiing;
}
