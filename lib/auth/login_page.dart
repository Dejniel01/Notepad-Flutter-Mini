import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/auth/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.error});

  final String? error;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 128.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).login(
                  _emailController.text,
                  _passwordController.text,
                );
              },
            ),
            ElevatedButton(
              child: const Text(
                "Register",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                //TODO: navigate to register page
              },
            ),
          ],
        ),
      ),
    );
  }
}
