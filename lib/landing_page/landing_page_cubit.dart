import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/notes_controller.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(const LandingPageLoading());

  final rng = Random();

  Future<void> load(User user) async {
    emit(const LandingPageLoading());
    try {
      final notes = await NotesController.getNotes(user);
      emit(
        LandingPageLoaded(
          notes: notes,
          isExpanded:
              List.generate(notes.length, (index) => rng.nextInt(5) == 0),
        ),
      );
    } on Exception catch (e) {
      emit(LandingPageError(error: e.toString()));
    }
  }
}

abstract class LandingPageState {
  const LandingPageState();
}

class LandingPageLoading extends LandingPageState {
  const LandingPageLoading();
}

class LandingPageError extends LandingPageState {
  const LandingPageError({
    required this.error,
  });
  final String error;
}

class LandingPageLoaded extends LandingPageState {
  const LandingPageLoaded({
    required this.notes,
    required this.isExpanded,
  });
  final List<Note> notes;
  final List<bool> isExpanded;
}
