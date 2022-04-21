part of 'january_cubit.dart';

@immutable
class JanuaryState {
  final List<ItemModel> documents;
  final bool isLoading;
  final String errorMessage;

  const JanuaryState({
    this.documents = const [],
    required this.isLoading,
    required this.errorMessage,
  });
}
