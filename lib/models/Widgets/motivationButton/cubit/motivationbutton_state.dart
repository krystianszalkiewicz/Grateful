part of 'motivationbutton_cubit.dart';

@immutable
class MotivationbuttonState {
  const MotivationbuttonState({
    required this.errorMessage,
    required this.documents,
    this.status = Status.initial,
  });
  final List<ItemModel> documents;
  final String? errorMessage;
  final Status status;
}
