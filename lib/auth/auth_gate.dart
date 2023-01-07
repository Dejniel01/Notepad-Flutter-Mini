import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/auth/auth_cubit.dart';
import 'package:notepad_flutter_mini/auth/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoggedOut:
            return LoginPage(key: key);
          case LoginError:
            return LoginPage(key: key, error: (state as LoginError).error);
          case LoggedIn:
            return LandingPage(user: (state as LoggedIn).user);
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
