class Todo {
  int? id;
  String title;
  bool isCompleted;

  Todo({this.id, required this.title, this.isCompleted = false});

//  Convert Todo to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

//  Convert Map to Todo
  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
