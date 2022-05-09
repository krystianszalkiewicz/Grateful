part of 'grateful_counter_cubit.dart';

@immutable
class GratefulCounterState {
  const GratefulCounterState({
    required this.errorMessage,
    required this.isLoadiing,
    required this.count ,
  });

  final List<ItemModel> count;
  final String errorMessage;
  final bool isLoadiing;
}
