class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifyDate,
  });

  int id;
  String title;
  String content;
  DateTime modifyDate;
  bool isPriority = false;
}
