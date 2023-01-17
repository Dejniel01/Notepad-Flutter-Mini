import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/auth/auth_cubit.dart';
import 'package:notepad_flutter_mini/auth/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final loginKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 450
              ? MediaQuery.of(context).size.width
              : 450,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 128.0),
                      const SizedBox(height: 32.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.pleasePassword;
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) =>
                            (loginKey.currentWidget! as ElevatedButton)
                                .onPressed!(),
                      ),
                      const SizedBox(height: 16.0),
                      if (widget.error != null)
                        Text(
                          widget.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        key: loginKey,
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
