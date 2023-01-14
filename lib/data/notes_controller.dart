import 'package:notepad_flutter_mini/data/database_user.dart';
import 'package:notepad_flutter_mini/data/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesController {
  static Future<List<Note>> getNotes(DataBaseUser user) async {
    final notesFromDb = await FirebaseFirestore.instance
        .collection('notes')
        .where('userId', isEqualTo: user.id)
        .get();
    final notes =
        notesFromDb.docs.map((e) => Note.fromMap(e.data(), e.id)).toList();
    return notes
      ..sort((a, b) {
        if (a.isPriority == b.isPriority) {
          return b.modifyDate.compareTo(a.modifyDate);
        }
        if (a.isPriority) {
          return -1;
        }
        if (b.isPriority) {
          return 1;
        }
        return 0;
      });
  }

  static Future<void> addNote(DataBaseUser user, Note note) async {
    await FirebaseFirestore.instance
        .collection('notes')
        .add(note.toMap(user.id));
  }

  static Future<void> updateNote(DataBaseUser user, Note note) async {
    await FirebaseFirestore.instance
        .collection('notes')
        .doc(note.id)
        .update(note.toMap(user.id));
  }

  static Future<void> deleteNote(Note note) async {
    await FirebaseFirestore.instance.collection('notes').doc(note.id).delete();
  }
}
