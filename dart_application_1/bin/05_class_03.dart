import 'dart:io';
import 'dart:math';

import 'package:dart_application_1/demo_class/class_01.dart';

import '04_function.dart';

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}

/* 
---------Abstract -------------
Trong Dart, một "abstract class" là một lớp mà bạn không thể tạo một instance trực tiếp từ nó. Thay vào đó, nó được sử dụng như một bản thiết kế để định nghĩa các phương thức và thuộc tính mà các lớp con cần phải triển khai. 
Abstract class cho phép bạn định nghĩa một giao diện chung cho các lớp con, giúp giảm sự phức tạp và tăng tính tái sử dụng trong mã của bạn.
Abstract class hữu ích trong việc xây dựng các hệ thống phức tạp hoặc để triển khai các phương thức chung cho một nhóm lớp con liên quan đến nhau.
Dưới đây là một số nguyên tắc khi sử dụng abstract class trong Dart:
1- Sử dụng từ khóa "abstract" để khai báo một abstract class
Abstract class cũng có thể triển khai method luôn nếu muốn
(class thường khi đã định nghĩa method thì bắt buộc phải setup body luôn, ko được bỏ trống)
Abstract class cũng có thể có propeties - subclass có thể @override hoặc ko


2- Lớp con extends abstract class và phải triển khai TẤT CẢ các phương thức abstract của lớp cha (method đã có body có thể ko @override)

3- Một lớp con có thể là một abstract class, nếu nó không triển khai tất cả các phương thức abstract của lớp cha:

4- Một abstract class có thể có các phương thức không phải abstract (có thể triển khai) và các thuộc tính:
 */
abstract class Shape {
  void draw(); // chỉ khai báo, subclass sẽ triển khai sau
  double area(double r);
  int tong(int a, int b) {
    return a + b;
  }

  int k = 10;
}

class Circle extends Shape {
  @override
  double area(double r) {
    return pi * r * r;
  }

  @override
  void draw() {
    print('draw.........');
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area(double r) {
    // TODO: implement area
    throw UnimplementedError();
  }

  @override
  void draw() {
    // TODO: implement draw
  }
}

abstract class Circle2 extends Shape {
  // Bạn có thể không triển khai draw() và area() ở đây
}

String? inputValue() {
  /* Khi nhập value from DEBUG CONSOLE bị lỗi: UnimplementedError: Global evaluation not currently supported
  Xử lý: open file .vscode\launch.json, chèn thêm dòng "console":"terminal" */
  stdout.write(
      'Vui lòng nhập giá trị: '); // Xuất thông báo yêu cầu người dùng nhập
  String? input = stdin
      .readLineSync(); // Đọc dữ liệu được nhập vào từ bàn phím và lưu vào biến input
  return input;
}

void main() {
  String? n = inputValue();
  print('Giá trị đã nhập: $n'); // In giá trị đã nhập
  double r = double.parse(n!);
  Circle circle = Circle();
  int m = circle.tong(5, 8);
  print('m: ${m}');
  double area = circle.area(r);
  print(
      'area: ${area.toStringAsFixed(2)}'); // toStringAsFixed(2) xuất ra string với độ dài phần thập phân chỉ định
}
