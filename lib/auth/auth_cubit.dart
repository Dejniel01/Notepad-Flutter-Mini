import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/data/user.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const LoggedOut());

  Future<void> login(String email, String password) async {
    emit(const LoginLoading());
    try {
      final user = await _login(email, password);
      emit(LoggedIn(user: user));
    } on Exception catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  Future<User> _login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return User(id: 1, email: email, name: 'John Doe');
  }
}

abstract class AuthState {
  const AuthState();
}

class LoggedOut extends AuthState {
  const LoggedOut();
}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginError extends AuthState {
  const LoginError({
    required this.error,
  });
  final String error;
}

class LoggedIn extends AuthState {
  const LoggedIn({
    required this.user,
  });
  final User user;
}
