import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/auth/auth_cubit.dart';
import 'package:notepad_flutter_mini/auth/auth_gate.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_cubit.dart';

import 'firebase_options.dart';

void main() async {
  print(1);
  WidgetsFlutterBinding.ensureInitialized();
  print(2);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(3);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(4);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocProvider(
        create: (context) => LandingPageCubit(),
        child: MaterialApp(
          title: 'Notepad Flutter Mini',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          // To properly unfocus text fields when tapping outside of them.
          home: Listener(
            onPointerDown: (event) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            child: const AuthGate(),
          ),
        ),
      ),
    );
  }
}
