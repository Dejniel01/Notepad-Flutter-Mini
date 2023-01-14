import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad_flutter_mini/data/database_user.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/landing_page/note_tile.dart';

class NoteTilesGrid extends StatefulWidget {
  const NoteTilesGrid({
    super.key,
    required this.user,
    required this.notes,
    required this.isExpanded,
  });

  final DataBaseUser user;
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

    return MasonryGridView.count(
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
    );
  }
}
