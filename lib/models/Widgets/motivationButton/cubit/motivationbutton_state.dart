part of 'motivationbutton_cubit.dart';

@immutable
class MotivationbuttonState {
  const MotivationbuttonState({
    required this.errorMessage,
    required this.isLoading,
    required this.documents,
  });
  final List<ItemModel> documents;
  final String errorMessage;
  final bool isLoading;
}
