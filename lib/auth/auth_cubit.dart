import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/data/database_user.dart';

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

  Future<DataBaseUser> _login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userFromDb = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return DataBaseUser.fromMap(
        userFromDb.docs.first.data(), userFromDb.docs.first.id);
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
  final DataBaseUser user;
}
