import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  void checkAuth() async {
    emit(const AuthProcessing());
    await Future.delayed(const Duration(seconds: 2));
    // TODO if (either.isLeft()) return emit(Unauthenticated(either.asLeft.getMessage));
    emit(const Authenticated());
  }
}
