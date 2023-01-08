import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/user.dart';
import 'package:notepad_flutter_mini/landing_page/landing_page_cubit.dart';
import 'package:notepad_flutter_mini/landing_page/note_tile.dart';
import 'package:notepad_flutter_mini/note_details/note_form.dart';

class NoteTilesGrid extends StatefulWidget {
  const NoteTilesGrid(
      {super.key,
      required this.notes,
      required this.isExpanded,
      required this.user});

  final User user;
  final List<Note> notes;
  final List<bool> isExpanded;

  @override
  State<NoteTilesGrid> createState() => _NoteTilesGridState();
}

class _NoteTilesGridState extends State<NoteTilesGrid> {
  int crossAxisCount = 2;
  List<Note>? filteredNotes;

  @override
  Widget build(BuildContext context) {
    crossAxisCount = MediaQuery.of(context).size.width ~/ 150;

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
                  id: -1,
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
      body: MasonryGridView.count(
        crossAxisCount: crossAxisCount,
        itemCount: filteredNotes!.length,
        itemBuilder: (context, index) {
          return NoteTile(
            user: widget.user,
            note: filteredNotes![index],
            isExpanded: widget.isExpanded[index],
            crossAxisCount: crossAxisCount,
          );
        },
      ),
    );
  }
}
