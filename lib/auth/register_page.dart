import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  final mailRegex = RegExp(r'^[\w-\.\+]+@([\w-]+\.)+[\w-]{2,4}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  String? _error;

  Future<bool> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        await FirebaseFirestore.instance.collection('users').add({
          'email': _email,
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _error = e.message;
        });
        return false;
      } on Exception catch (e) {
        setState(() {
          _error = e.toString();
        });
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 450
              ? MediaQuery.of(context).size.width
              : 450,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FlutterLogo(size: 128.0),
                        const SizedBox(height: 32.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.pleaseEmail;
                            }

                            if (!widget.mailRegex.hasMatch(value.trim())) {
                              return AppLocalizations.of(context)!
                                  .pleaseValidEmail;
                            }

                            _email = value;
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.password),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleasePassword;
                            }
                            if (!widget.passwordRegex.hasMatch(value)) {
                              return AppLocalizations.of(context)!
                                  .pleaseStrongPassword;
                            }
                            _password = value;
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .confirmPassword),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseConfirmPassword;
                            }
                            if (value != _password) {
                              return AppLocalizations.of(context)!
                                  .passwordsNotMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        if (_error != null)
                          Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          child: Text(
                            AppLocalizations.of(context)!.register,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () async {
                            _register().then((value) =>
                                value ? Navigator.pop(context) : null);
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
      ),
    );
  }
}
