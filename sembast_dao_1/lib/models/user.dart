// lib/models/user.dart

class User {
  int id;
  final String name;
  final int age;
  bool check;
  bool VIP;

  User({
    required this.id,
    required this.name,
    required this.age,
    this.check = false,
    this.VIP = true,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'check': check, 'VIP': VIP};
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int,
        name: map['name'] as String,
        age: map['age'] as int,
        check: map['check'] as bool? ?? false,
        VIP: map['VIP'] as bool? ?? false);
  }
}
