import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/auth/auth_cubit.dart';
import 'package:notepad_flutter_mini/auth/auth_gate.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocProvider(
        create: (context) => LandingPageCubit(),
        child: MaterialApp(
          title: 'Notepad Flutter Mini',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}
