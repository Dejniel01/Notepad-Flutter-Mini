class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifyDate,
    this.isPriority = false,
  });

  String id;
  String title;
  String content;
  DateTime modifyDate;
  bool isPriority;

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      title: map['title'],
      content: map['content'],
      modifyDate: map['modifyDate'].toDate(),
      isPriority: map['isPriority'],
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'title': title,
      'content': content,
      'modifyDate': modifyDate,
      'isPriority': isPriority,
      'userId': userId,
    };
  }
}
