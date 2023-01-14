import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_cubit.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_scaffold.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LandingPageCubit>(context).load(user);
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<LandingPageCubit>(context).load(user),
      child: BlocBuilder<LandingPageCubit, LandingPageState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case LandingPageError:
              return Scaffold(
                body: Center(
                  child: Text((state as LandingPageError).error),
                ),
              );
            case LandingPageLoaded:
              return LandingPageScaffold(
                user: user,
                notes: (state as LandingPageLoaded).notes,
                isExpanded: state.isExpanded,
              );
            default:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
      ),
    );
  }
}
