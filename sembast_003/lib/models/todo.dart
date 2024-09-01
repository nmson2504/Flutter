class Todo {
  int? id;
  String name;
  int age;

  Todo({
    this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }
}
