/* 
# Use code generation for medium to large projects
 Serializing JSON using code generation libraries
Although there are other libraries available, this guide uses json_serializable, an automated source code generator that generates the JSON serialization boilerplate for you.
 - cmd: flutter pub add json_annotation dev:build_runner dev:json_serializable
  flutter auto add dependencies vào file pubspec.yaml như sau: 
  json_annotation vào phần dependencies:
  build_runner và json_serializable vào phần dev_dependencies:
 - Khi tạo class model lần đầu tiên(vidu này là file user.dart), bạn sẽ gặp lỗi tương tự như mô tả https://docs.flutter.dev/data-and-backend/serialization/json#code-generation.
  Đó là do chưa chạy generated code for the model class. To resolve this, run the code generator theo 1 trong 2 cách sau tại the project root:
   - One-time code generation: dart run build_runner build --delete-conflicting-outputs
   - Generating code continuously: dart run build_runner watch --delete-conflicting-outputs - json_serializable auto generated code lại khi có change file
Trình tạo mã nguồn tạo một tệp có tên là user.g.dart, có tất cả logic tuần tự hóa cần thiết. Bạn không còn phải viết các bài kiểm tra tự động để đảm bảo tuần tự hóa hoạt động nữa
 */
/* 
Các bước run json_serializable với json lồng
(vidu với sources: '{"name":"John Smith","email":"john@example.com","address":{"street":"My st.","city":"New York"}}')
 1- Tạo các file xxx.dart chứa class định nghĩa các object tương ứng(User, Address) với cú pháp json_serializable. Lưu ý: lúc này chưa khai báo các tuộc tính có data type liên quan tới class khác(chưa khai báo Address address; trong class User)
 2- Run dart run build_runner watch --delete-conflicting-outputs để tạo các file xxx.g.dart tương ứng
 Nếu bước này run ko lỗi thì có thể tạo các class đầy đủ thuộc tính luôn và ko cần thêm bước 3
 3- Thêm các thuộc tính với kiểu link từ các class liên quan(thêm Address address; vào class User)
 
 */
import 'dart:convert';

import 'package:flutter/material.dart';

import 'user_nested.dart';
import 'user_01.dart';

class MyJson01 extends StatelessWidget {
  const MyJson01({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('JSON Use code generation Sample')),
        body: const Json02(),
      ),
    );
  }
}

class Json01 extends StatelessWidget {
  const Json01({super.key});

  @override
  Widget build(BuildContext context) {
    String jsonString =
        '{"name":"John Smith","email":"john@example.com","address":{"street":"My st.","city":"New York"}}';
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var user = User.fromJson(userMap);

    print('Hello ${user.name}');
    print('Address ${user.address.street}, ${user.address.city}');
    print('We sent the verification link to ${user.email}');
    user.name = 'Hero Live';
    user.address.street = 'street 001';
    String json = jsonEncode(user);
    print(json);
    return const Placeholder();
  }
}

// demo JsonKey
// mô tả các JsonKey trong file user_01.dart
class Json02 extends StatelessWidget {
  const Json02({super.key});

  @override
  Widget build(BuildContext context) {
    String jsonString = '{"name":"John Cu","email":"john@example.com","diachi":"179/24 TVD"}';
    // String jsonString2 = '{"name":"John Cu","diachi":"179/24 TVD"}';
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var user = User01.fromJson(userMap);

    print('Hello ${user.name}');
    print('Address ${user.address}, ${user.email}');
    print('We sent the verification link to ${user.email}');
    user.name = 'Hero Live';
    user.address = 'street 001';
    String json = jsonEncode(user);
    print(json);

    //
    Map<String, dynamic> jsonMap = {"name": "John Le", "email": "cule@example.com", "diachi": "179/20 TVD"};
    Map<String, dynamic> jsonMap2 = {"email": "cule@example.com", "diachi": "179/20 TVD"};
    var user1 = User01.fromJson(jsonMap2);
    print('user1: ${user1}'); // Override the toString() method to print all properties

    return const Placeholder();
  }
}
