import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/landing_page/note_tiles_grid.dart';
import 'package:notepad_flutter_mini/note_details/note_form.dart';

class LandingPageScaffold extends StatefulWidget {
  const LandingPageScaffold({
    super.key,
    required this.user,
    required this.notes,
    required this.isExpanded,
  });

  final User user;
  final List<Note> notes;
  final List<bool> isExpanded;

  @override
  State<LandingPageScaffold> createState() => _LandingPageScaffoldState();
}

class _LandingPageScaffoldState extends State<LandingPageScaffold> {
  List<Note>? filteredNotes;

  @override
  Widget build(BuildContext context) {
    filteredNotes ??= widget.notes;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            prefixIconColor: Colors.white,
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            setState(
              () {
                filteredNotes = widget.notes
                    .where((note) =>
                        note.title.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteForm(
                title: 'New note',
                user: widget.user,
                note: Note(
                  id: '',
                  title: '',
                  content: '',
                  modifyDate: DateTime.now(),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(128, 255, 243, 202),
              Colors.white,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: NoteTilesGrid(
          notes: filteredNotes!,
          user: widget.user,
          isExpanded: widget.isExpanded,
        ),
      ),
    );
  }
}
