import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_flutter_mini/data/database_user.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/notes_controller.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_cubit.dart';
import 'package:notepad_flutter_mini/note_details/note_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key, required this.note, required this.user});

  final DataBaseUser user;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.noteDetails,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "deleteButton",
            onPressed: () {
              NotesController.deleteNote(note);
              Navigator.pop(context);
              BlocProvider.of<LandingPageCubit>(context).load(user);
            },
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "editButton",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteForm(
                    title: AppLocalizations.of(context)!.editNote,
                    user: user,
                    note: note,
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteForm(
                      title: AppLocalizations.of(context)!.editNote,
                      user: user,
                      note: note,
                      isTitleFocused: true,
                    ),
                  ),
                );
              },
              child: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteForm(
                        title: AppLocalizations.of(context)!.editNote,
                        user: user,
                        note: note,
                        isContentFocused: true,
                      ),
                    ),
                  );
                },
                child: Text(
                  note.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
