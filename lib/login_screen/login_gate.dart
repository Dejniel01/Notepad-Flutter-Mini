import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/login_screen/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginGate extends StatelessWidget {
  const LoginGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      switch (state.runtimeType) {
        case LoginInitial:
          return const _LoginInitial();
        case LoginLoading:
          return const _LoginLoading();
        case LoginError:
          return _LoginError(error: (state as LoginError).error);
        case LoginSuccess:
          return _LoginSuccess(user: (state as LoginSuccess).user);
        default:
          return const _LoginInitial();
      }
    });
  }
}
