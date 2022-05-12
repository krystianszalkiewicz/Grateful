part of 'grateful_cubit.dart';

@immutable
class GratefulState {
  final List<ItemModel> documents;
  final Status status;
  final String? errorMessage;

   const GratefulState({
    required this.documents,
    required this.errorMessage,
    this.status = Status.initial,
  });
}
