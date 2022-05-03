// ignore_for_file: non_constant_identifier_names

part of 'month_cubit.dart';

@immutable
class MonthState {
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoadiing;

  const MonthState({
    required this.errorMessage,
    required this.isLoadiing,
    required this.documents,
  });
}
