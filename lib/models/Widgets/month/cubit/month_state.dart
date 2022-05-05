part of 'month_cubit.dart';

@immutable
class MonthState {
  const MonthState({
    required this.errorMessage,
    required this.isLoadiing,
    required this.count ,
  });

  final List<ItemModel> count;
  final String errorMessage;
  final bool isLoadiing;
}
