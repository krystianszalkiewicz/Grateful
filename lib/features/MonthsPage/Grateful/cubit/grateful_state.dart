part of 'grateful_cubit.dart';

@immutable
class GratefulState {
  final List<ItemModel> documents;
  final bool isLoading;
  final String errorMessage;

  const GratefulState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMessage,
  });
}
