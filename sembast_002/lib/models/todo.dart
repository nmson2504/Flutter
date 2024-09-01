class Todo {
  int? id;
  String title;
  String desc;
  bool isCompleted;

  Todo(
      {this.id,
      required this.title,
      required this.desc,
      this.isCompleted = false});

// chuyển đổi đối tượng Todo thành một Map<String, dynamic>. Việc này giúp dễ dàng lưu trữ đối tượng trong cơ sở dữ liệu hoặc truyền nó qua mạng.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': desc,
      'isCompleted': isCompleted,
    };
  }

// chuyển đổi một Map<String, dynamic> trở lại thành một đối tượng Todo. Điều này thường được sử dụng khi lấy dữ liệu từ cơ sở dữ liệu hoặc khi nhận dữ liệu từ một dịch vụ và cần chuyển nó thành đối tượng Todo để xử lý trong ứng dụng.
  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      title: map['title'] as String,
      desc: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
