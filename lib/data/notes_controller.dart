import 'dart:math';

import 'package:notepad_flutter_mini/data/note.dart';
import 'package:notepad_flutter_mini/data/user.dart';

class NotesController {
  static final _notes = [
    Note(
      id: 1,
      title: 'Note 1',
      content: 'Content 1',
      modifyDate: DateTime.utc(2021, 1, 1),
    ),
    Note(
      id: 2,
      title: 'Note 2',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut at convallis velit. Integer tincidunt libero ante, id accumsan leo elementum molestie. Nullam aliquet orci eget pharetra vestibulum. Vivamus nunc dolor, maximus vitae orci tristique, auctor tempor lectus. Quisque facilisis lacus et velit feugiat tincidunt. Quisque eleifend dui a rutrum porta. Aenean eu convallis sem, at cursus tortor. Maecenas porttitor nec ligula eu consectetur. Mauris a lacus sit amet ex blandit tempor non sed dolor. Sed et auctor sem, consequat hendrerit lacus. Vivamus blandit nunc tortor, vitae rutrum risus sodales ultricies. In nisl mi, convallis quis libero quis, sollicitudin aliquam est.',
      modifyDate: DateTime.utc(2020, 6, 6),
    ),
    Note(
      id: 3,
      title: 'This is a very long and interesting title',
      content: 'Content 3',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
    Note(
      id: 4,
      title: 'Note 4',
      content: 'Content 4',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
    Note(
      id: 5,
      title: 'This also is a very insteresting, and probably too long title',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut at convallis velit. Integer tincidunt libero ante, id accumsan leo elementum molestie. Nullam aliquet orci eget pharetra vestibulum. Vivamus nunc dolor, maximus vitae orci tristique, auctor tempor lectus. Quisque facilisis lacus et velit feugiat tincidunt. Quisque eleifend dui a rutrum porta. Aenean eu convallis sem, at cursus tortor. Maecenas porttitor nec ligula eu consectetur. Mauris a lacus sit amet ex blandit tempor non sed dolor. Sed et auctor sem, consequat hendrerit lacus. Vivamus blandit nunc tortor, vitae rutrum risus sodales ultricies. In nisl mi, convallis quis libero quis, sollicitudin aliquam est.',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
    Note(
      id: 6,
      title: 'Note 6',
      content: 'Content 6',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
    Note(
      id: 7,
      title: 'Note 7',
      content: 'Content 7',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
    Note(
      id: 8,
      title: 'Note 8',
      content: 'Content 8',
      modifyDate: DateTime.utc(2020, 1, 1),
    ),
  ];

// temporary before firebase
  static final rng = Random();

  static Future<List<Note>> getNotes(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return _notes
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

  static Future<void> addNote(User user, Note note) async {
    await Future.delayed(const Duration(seconds: 2));

    // temporary before firebase
    do {
      note.id = rng.nextInt(1000000);
    } while (_notes.indexWhere((element) => element.id == note.id) != -1);

    _notes.add(note);
  }

  static Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(seconds: 2));
    final index = _notes.indexWhere((element) => element.id == note.id);
    _notes[index] = note;
  }
}
