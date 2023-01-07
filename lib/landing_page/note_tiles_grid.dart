import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/user.dart';
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

  @override
  Widget build(BuildContext context) {
    crossAxisCount = MediaQuery.of(context).size.width ~/ 150;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
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
        child: const Icon(Icons.add),
      ),
      body: MasonryGridView.count(
        crossAxisCount: crossAxisCount,
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return NoteTile(
            user: widget.user,
            note: widget.notes[index],
            isExpanded: widget.isExpanded[index],
            crossAxisCount: crossAxisCount,
          );
        },
      ),
    );
  }
}
