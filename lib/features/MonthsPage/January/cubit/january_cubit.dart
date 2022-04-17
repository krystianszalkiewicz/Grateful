import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'january_state.dart';

class JanuaryCubit extends Cubit<JanuaryState> {
  JanuaryCubit() : super(JanuaryInitial());
}
