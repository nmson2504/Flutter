import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  int id = 0;
  String description;
  bool isCompleted;

  Task({required this.description, this.isCompleted = false});
}
