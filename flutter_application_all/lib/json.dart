/* 
Most mobile and web apps use JSON for tasks such as exchanging data with a web server. This page discusses Dart support for JSON serialization and deserialization: converting Dart objects to and from JSON.

Libraries
The following libraries and packages are useful across Dart platforms:

dart:convert
Converters for both JSON and UTF-8 (the character encoding that JSON requires).

package:json_serializable
An easy-to-use code generation package. When you add some metadata annotations and use the builder provided by this package, the Dart build system generates serialization and deserialization code for you.

package:built_value
A powerful, opinionated alternative to json_serializable.
 --------------------
 # Use manual serialization for smaller projects
  Flutter has a built-in dart:convert library that includes a straightforward JSON encoder and decoder.

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
   - Generating code continuously: dart run build_runner watch --delete-conflicting-outputs
Trình tạo mã nguồn tạo một tệp có tên là user.g.dart, có tất cả logic tuần tự hóa cần thiết. Bạn không còn phải viết các bài kiểm tra tự động để đảm bảo tuần tự hóa hoạt động nữa

 */
import "dart:convert";

import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "user.dart";
import 'person.dart';

class MyJson extends StatelessWidget {
  const MyJson({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('JSON Sample')),
        body: const Json01(),
      ),
    );
  }
}

class Json01 extends StatelessWidget {
  const Json01({super.key});

  @override
  Widget build(BuildContext context) {
    // Một số cách khởi tạo đối tượng có kiểu Map<String, dynamic> để xử lý trong Dart
    // C1: Từ String -> jsonDecode convert to _JsonMap -> truy xuất theo cú pháp user['email']
    // jsonDecode function return a dynamic - convert json string to map object
    String jsonString = '{"name": "John Smith","email": "john@example.com"}';
    final user = jsonDecode(jsonString) as Map<String, dynamic>; // dùng as ép kiểu
    final user1 = jsonDecode(jsonString); // ko cần ép kiểu
    print('user: ${user.runtimeType}');
    print('user1: ${user1.runtimeType}');
    print('user, ${user['name']}!');
    user['name'] = 'Lê Cu';
    print('user, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');
    print('user1, ${user1['name']}!');
    print('We sent the verification link to ${user1['email']}.');
    print('----------------------------------');

// C2: Khơi tạo từ map - type: IdentityMap<String, dynamic> -> truy xuất với cú pháp jsonMap['name']
    // Example 1
    Map<String, dynamic> jsonMap = {'id': 1, 'name': 'John Doe', 'age': 25, 'VIP': true, 'check': false};
    print('jsonMap: ${jsonMap.runtimeType}');
    print('Howdy, ${jsonMap['name']}!');
    print('We sent the verification link to ${jsonMap['age']}.');
    // Example 2
    Map<String, String> userModel = {"name": "John Smith", "email": "john@example.com"};
    print('userModel: ${userModel.runtimeType}');
    print('Howdy, ${userModel['name']}!');
    userModel['email'] = 'nmson254@gmail.com';
    print('We sent the verification link to ${userModel['email']}.');
    print('----------------------------------');

    // C3: Khỏi tạo từ constructor User.fromJson với tham số input là map, return instance của User -> truy xuất với cú pháp userObject.email
    dynamic userObject = UserManual.fromJson(user);
    print('userObject: ${userObject.runtimeType}'); // return User
    print('Howdy, ${userObject.name}!');
    userObject.name = 'Tú Anh';
    print('Howdy, ${userObject.name}!');
    print('We sent the verification link to ${userObject.email}.');

    // To encode a object(tạo bằng jsonDecode) to string, pass the object to the jsonEncode() function. You don't need to call the toJson() method, since jsonEncode() already does it for you.
    // hai hàm jsonEncode() của flutter và toJson() method của model class có cùng chức năng
    String json = jsonEncode(user); // jsonEncode() return String
    print('json type: ${json.runtimeType}');
    print('json: ${json}');

    // converts a User instance into a map with method toJson()
    dynamic json2 = userObject.toJson();
    print('json2: ${json2.runtimeType}');
    print('json2: ${json2}');

    return const Placeholder();
  }
}

// json list
class Json01a extends StatelessWidget {
  const Json01a({super.key});

  @override
  Widget build(BuildContext context) {
    final jsonArray = [
      {'score': 12},
      {'score': 44},
      {'score': 10},
      {'score': 20},
      {'score': 52}
    ];
    print('jsonArray: ${jsonArray.runtimeType}'); // List<Map<String, int>>
    print('jsonArray: ${jsonArray}'); // [{score: 12}, {score: 44}, {score: 10}, {score: 20}, {score: 52}]
    print('jsonArray[0]: ${jsonArray[0]}'); // {score: 12}
    // In ra các value của score
    for (var map in jsonArray) {
      print(map['score']);
    }
    // jsonEncode convert list map to string
    String jsonString = jsonEncode(jsonArray);
    print('jsonString: ${jsonString.runtimeType}');
    print(
        'jsonString: ${jsonString}'); // [{"score":12},{"score":44},{"score":10},{"score":20},{"score":52}] - khác với json list ở ""
    // jsonDecode convert string to list dynamic
    final jsonList = jsonDecode(jsonString);
    print('jsonList: ${jsonList.runtimeType}'); // List<dynamic>
    print('jsonList: ${jsonList}'); // [{score: 12}, {score: 44}, {score: 10}, {score: 20}, {score: 52}]
    print('jsonList: ${jsonList[1]}');
    // In ra các value của score
    for (var map in jsonList) {
      print(map['score']);
    }
    // In ra value của score tại index 1
    print('jsonList[1]["score"]: ${jsonList[1]['score']}'); // 44
    // chuyển trực tiếp chuỗi JSON về List<Map<String, int>> ngay khi khai báo bằng cách kết hợp jsonDecode và map như sau:
    final List<Map<String, int>> scoreList =
        (jsonDecode('[{"score":12},{"score":44},{"score":10},{"score":20},{"score":52}]') as List<dynamic>)
            .map((item) => Map<String, int>.from(item))
            .toList();
    print('scoreList: ${scoreList.runtimeType}'); // List<Map<String, int>>
    print('scoreList: ${scoreList}');
    // In ra các value của score
    for (var map in scoreList) {
      print(map['score']);
    }
// In ra value của score tại index 1
    print('scoreList[1]["score"]: ${scoreList[1]['score']}'); // 44
    return const Placeholder();
  }
}

// json lồng
/* khi giải mã một chuỗi JSON thành một đối tượng (thường là Map), các phần tử trong đó không có thứ tự cụ thể để có thể truy cập qua chỉ số (index) như trong một List. Vì Map là một cấu trúc dữ liệu không có thứ tự, bạn chỉ có thể truy cập các phần tử của nó thông qua các khóa (keys).
Nếu muốn truy cập vào các phần tử trong một Map theo thứ tự giống như qua các chỉ số, bạn có thể làm như sau:
Chuyển đổi các khóa của Map thành một danh sách (List). */
class Json01b extends StatelessWidget {
  const Json01b({super.key});

  @override
  Widget build(BuildContext context) {
    String jsonNestedString = '''{
        
            "John": {
                "age": 30,
                "position": "developer"
            },
            "Mary": {
                "age": 25,
                "position": "designer"
            }
        
    }''';
    print('jsonNestedString: ${jsonNestedString}');

    final jsonNested = jsonDecode(jsonNestedString);
    print('jsonNested: ${jsonNested.runtimeType}');
    print('jsonNested: ${jsonNested}'); // {John: {age: 30, position: developer}, Mary: {age: 25, position: designer}}
    print('jsonNested: ${jsonNested['John']}'); // {age: 30, position: developer}
    print('jsonNested: ${jsonNested['John']['age']}'); // 30
    // Duyệt qua từng phần tử trong jsonNested và in ra
    jsonNested.forEach((key, value) {
      print('$key: $value');
      print('----');
    });
    // Chuyển đổi các values của Map thành List
    final jsonListVal = jsonNested.values.toList();
    print('jsonListVal: $jsonListVal'); // [{age: 30, position: developer}, {age: 25, position: designer}]
    print('jsonListVal[1]: ${jsonListVal[1]}'); // {age: 25, position: designer}]
    // Chuyển đổi mảng Map thành List
    // Chuyển đổi mảng key-value thành List
    final jsonList = jsonNested.entries.map((entry) {
      return {
        "name": entry.key,
        "details": entry.value,
      };
    }).toList();
    print(
        'jsonList: ${jsonList}'); // [{name: John, details: {age: 30, position: developer}}, {name: Mary, details: {age: 25, position: designer}}] - 2 key 'name' and 'details' do method map thêm vào

    print('jsonList[1]: ${jsonList[1]}'); //{name: Mary, details: {age: 25, position: designer}}
    print('jsonList[1]: ${jsonList[1]['name']}'); // Mary
    // In ra các value của score
    for (var map in jsonList) {
      print(map['name']);
      print(map['details']['age']);
    }
    return const Placeholder();
  }
}

// uses json_serializable
// tiếp theo tại json01.dart
class Json02 extends StatelessWidget {
  const Json02({super.key});

  @override
  Widget build(BuildContext context) {
    String jsonString = '{"name": "John Down","email": "nmson@example.com"}';
    final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
    final user = User.fromJson(userMap);
    print('user: ${user}'); // output: Instance of 'User' do là instance của User class
    print('user: ${user.runtimeType}');
    print('user: ${user.name}');
    print('user: ${user.email}');

    print('-----------------------------');
    // Chuyển đổi từ JSON sang đối tượng User
    Map<String, dynamic> json = {'name': 'John Cu', 'email': 'john.cu@example.com'};
    User user2 = User.fromJson(json);
    print('user2: ${user2.runtimeType}');
    // Chuyển đổi từ đối tượng User sang JSON
    Map<String, dynamic> jsonBack = user2.toJson();
    print(jsonBack.runtimeType); // Output: IdentityMap<String, dynamic>
    print(jsonBack); // Output: {name: John Doe, email: john@example.com}
    print('-----------------------------');
    //
    String jsonString2 = '{"firstName": "Nguyễn","lastName":"Minh","dateOfBirth": "25-04-1974"}';
    final personMap = jsonDecode(jsonString2) as Map<String, dynamic>;
    final person = Person.fromJson(personMap);
    print('person: ${person.runtimeType}'); // output: Person
    print('person: ${person.firstName} ${person.lastName}');
    print('person: ${person.dateOfBirth}'); // output: person: 1974-04-25 00:00:00.000
    print('person with DateFormat: ${DateFormat("dd-MM-yyyy").format(person.dateOfBirth!)}'); // output: 25-04-1974

    print('person: ${person.formattedDateOfBirth}'); // output: 25-04-1974
    final personObj = person.toJson();
    print('personObj: ${personObj.runtimeType}'); // IdentityMap<String, dynamic>
    print('personObj: ${personObj}'); // output: {firstName: Nguyễn, lastName: Minh, dateOfBirth: 25-04-1974}

    return const Placeholder();
  }
}

// model classes
/* 
A User.fromJson() constructor, for constructing a new User instance from a map structure.
A toJson() method, which converts a User instance into a map.
 */
class UserManual {
  String name;
  final String email;

  UserManual(this.name, this.email);

// Constructor tạo instance User từ input là map
  UserManual.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String;
// converts a User instance into a map
  // toJson() method của model class có cùng chức năng với hàm jsonEncode() của flutter
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
