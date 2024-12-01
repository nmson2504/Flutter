// contact_model.dart
import 'package:hive/hive.dart';

part 'contact_model.g.dart'; // Tạo ra file này bằng `dart run build_runner build`

const String contactsBoxName = "contacts";
/* 
 - Mỗi thuộc tính được đánh số (HiveField) để Hive quản lý và lưu trữ.
 - Mỗi kiểu dữ liệu hoặc lớp được annotation @HiveType(typeId: n), được dùng để xác định rằng chú thích này sẽ được lưu trữ trong cơ sở dữ liệu Hive. typeId là mã định danh duy nhất cho kiểu dữ liệu này, giúp Hive phân biệt giữa các kiểu dữ liệu khác nhau khi lưu trữ và truy xuất.
typeId: Đây là một số nguyên duy nhất được gán cho mỗi lớp hoặc kiểu dữ liệu mà bạn muốn lưu trữ trong Hive. Mỗi kiểu cần có một typeId khác nhau trong cùng một cơ sở dữ liệu, và các typeId phải cố định, không được thay đổi sau khi dữ liệu đã được lưu. Nếu thay đổi, dữ liệu cũ sẽ không thể giải mã được nữa.
 */

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  Family,
  @HiveField(1)
  Friend,
}

const relationships = <Relationship, String>{
  Relationship.Family: "Family",
  Relationship.Friend: "Friend",
};

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  Relationship relationship;
  @HiveField(3)
  String phoneNumber;

  Contact(this.name, this.age, this.phoneNumber, this.relationship);
}
