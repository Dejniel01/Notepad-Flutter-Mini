import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/user.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final user = await _login(email, password);
      emit(LoginSuccess(user: user));
    } on Exception catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  Future<User> _login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return User(id: 1, email: email, name: 'John Doe');
  }
}

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginError extends LoginState {
  const LoginError({
    required this.error,
  });
  final String error;
}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    required this.user,
  });
  final User user;
}
