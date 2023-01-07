import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/notes_controller.dart';
import 'package:notepad_flutter_mini/data/user.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({
    super.key,
    required this.title,
    required this.note,
    required this.user,
  });

  final String title;
  final User user;
  final Note note;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  String? _noteTitle;
  String? _noteContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState!.save();
          widget.note.title = _noteTitle!;
          widget.note.content = _noteContent!;
          widget.note.modifyDate = DateTime.now();
          if (widget.note.id == -1) {
            NotesController.addNote(widget.user, widget.note);
          } else {
            NotesController.updateNote(widget.note);
          }
          Navigator.pop(context);
        },
        child: const Icon(Icons.done),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.note.title,
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _noteTitle = value,
            ),
            TextFormField(
              initialValue: widget.note.content,
              decoration: const InputDecoration(labelText: 'Content'),
              onSaved: (value) => _noteContent = value,
            ),
          ],
        ),
      ),
    );
  }
}
