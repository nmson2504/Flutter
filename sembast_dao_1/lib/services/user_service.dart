import 'package:faker/faker.dart';
import '../models/user.dart';

class UserService {
  static Faker faker = Faker();

  // Hàm sinh người dùng ngẫu nhiên
  static User generateRandomUser() {
    final id = DateTime.now().millisecondsSinceEpoch;
    final name = faker.person.name();
    final age = faker.randomGenerator.integer(100, min: 18);

    return User(
      id: id,
      name: name,
      age: age,
    );
  }
}
