import 'package:objectbox/objectbox.dart';

/* 
@Entity() là một chú thích (annotation) được sử dụng trong ObjectBox để đánh dấu một lớp là một thực thể (entity) có thể được lưu trữ trong cơ sở dữ liệu ObjectBox. Đây là một phần quan trọng của cách ObjectBox hoạt động với Dart và Flutter.
Ý nghĩa:
@Entity() cho ObjectBox biết rằng lớp Note đại diện cho một bảng trong cơ sở dữ liệu.
Nó chỉ định rằng mỗi instance của Note sẽ được lưu trữ như một bản ghi riêng biệt trong cơ sở dữ liệu. 

File objectbox.g.dart sẽ được tự động tạo ra và chứa mã được phát sinh dựa trên nội dung trong model.dart. Đây là một phần quan trọng của cách ObjectBox hoạt động với Dart và Flutter. Hãy tìm hiểu chi tiết hơn:
Cơ chế hoạt động:
Khi bạn chạy lệnh flutter pub run build_runner build, ObjectBox sẽ quét qua các file trong dự án của bạn, đặc biệt là các file chứa các lớp được đánh dấu bằng @Entity().
Dựa trên các entity này, ObjectBox sẽ tự động tạo ra file objectbox.g.dart chứa mã cần thiết để làm việc với cơ sở dữ liệu.
Có thể tạo thêm nhiều file model như model2.dart, model3.dart, v.v., và ObjectBox sẽ quét qua tất cả các file này khi bạn chạy lệnh flutter pub run build_runner build.
Nó sẽ tìm kiếm các lớp được đánh dấu bằng @Entity() trong tất cả các file.
Sau đó, nó sẽ tạo ra mã cần thiết trong file objectbox.g.dart dựa trên tất cả các entity được tìm thấy.

File objectbox-model.json là một file quan trọng trong hệ thống ObjectBox, đóng vai trò như một "bản thiết kế" cho cơ sở dữ liệu của bạn. Nó giúp ObjectBox quản lý cấu trúc cơ sở dữ liệu, theo dõi các thay đổi, và đảm bảo tính nhất quán giữa mã nguồn và dữ liệu thực tế trên thiết bị của người dùng.
Lưu ý quan trọng:
Nên đưa file này vào version control (như Git): Điều này giúp đảm bảo tính nhất quán giữa các môi trường phát triển và giữa các phiên bản của ứng dụng.
Không nên chỉnh sửa thủ công: File này được quản lý tự động bởi ObjectBox, và việc chỉnh sửa trực tiếp có thể gây ra vấn đề.
*/
@Entity()
class Note {
  int id = 0; // ID tự động tăng
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });
}

@Entity()
class User {
  int id = 0;
  String name;
  String email;

  User({required this.name, required this.email});
}
