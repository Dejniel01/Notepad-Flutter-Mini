import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/data/database_user.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/landing_page/note_tiles_grid.dart';
import 'package:notepad_flutter_mini/note_details/note_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPageScaffold extends StatefulWidget {
  const LandingPageScaffold({
    super.key,
    required this.user,
    required this.notes,
    required this.isExpanded,
  });

  final DataBaseUser user;
  final List<Note> notes;
  final List<bool> isExpanded;

  @override
  State<LandingPageScaffold> createState() => _LandingPageScaffoldState();
}

class _LandingPageScaffoldState extends State<LandingPageScaffold> {
  List<Note>? filteredNotes;
  int selectedSorting = 0;

  @override
  Widget build(BuildContext context) {
    filteredNotes ??= widget.notes;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  border: InputBorder.none,
                  prefixIconColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      filteredNotes = widget.notes
                          .where((note) => note.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    },
                  );
                },
              ),
            ),
            PopupMenuButton(
              onSelected: (value) => setState(
                () {
                  selectedSorting = value;
                  filteredNotes!.sort((a, b) {
                    if (a.isPriority == b.isPriority) {
                      switch (value) {
                        case 0:
                          return b.modifyDate.compareTo(a.modifyDate);
                        case 1:
                          return a.modifyDate.compareTo(b.modifyDate);
                        case 2:
                          return a.title
                              .toLowerCase()
                              .compareTo(b.title.toLowerCase());
                        case 3:
                          return b.title
                              .toLowerCase()
                              .compareTo(a.title.toLowerCase());
                      }
                    }
                    if (a.isPriority) {
                      return -1;
                    }
                    if (b.isPriority) {
                      return 1;
                    }
                    return 0;
                  });
                },
              ),
              itemBuilder: ((context) => [
                    CheckedPopupMenuItem(
                      value: 0,
                      checked: selectedSorting == 0,
                      child: Text(AppLocalizations.of(context)!.sortDateLatest),
                    ),
                    CheckedPopupMenuItem(
                      value: 1,
                      checked: selectedSorting == 1,
                      child: Text(AppLocalizations.of(context)!.sortDateOldest),
                    ),
                    CheckedPopupMenuItem(
                      value: 2,
                      checked: selectedSorting == 2,
                      child: Text(AppLocalizations.of(context)!.sortTitleAZ),
                    ),
                    CheckedPopupMenuItem(
                      value: 3,
                      checked: selectedSorting == 3,
                      child: Text(AppLocalizations.of(context)!.sortTitleZA),
                    ),
                  ]),
              child: const Icon(
                Icons.sort,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteForm(
                title: AppLocalizations.of(context)!.newNote,
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
