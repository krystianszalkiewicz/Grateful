part of 'grateful_counter_cubit.dart';

@immutable
class GratefulCounterState {
  const GratefulCounterState(
      {required this.errorMessage,
      required this.count,
      this.status = Status.initial});

  final List<ItemModel> count;
  final String? errorMessage;
  final Status status;
}
