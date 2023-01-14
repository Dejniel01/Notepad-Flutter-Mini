import 'package:flutter/material.dart';
import 'package:notepad_flutter_mini/data/database_user.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/notes_controller.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({
    super.key,
    required this.title,
    required this.note,
    required this.user,
  });

  final String title;
  final DataBaseUser user;
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
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState!.save();
          widget.note.title = _noteTitle!;
          widget.note.content = _noteContent!;
          widget.note.modifyDate = DateTime.now();
          if (widget.note.id == '') {
            NotesController.addNote(widget.user, widget.note);
          } else {
            NotesController.updateNote(widget.user, widget.note);
          }
          Navigator.pop(context);
        },
        child: const Icon(Icons.done, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.note.title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  onSaved: (value) => _noteTitle = value,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  initialValue: widget.note.content,
                  decoration: const InputDecoration(labelText: 'Content'),
                  onSaved: (value) => _noteContent = value,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
