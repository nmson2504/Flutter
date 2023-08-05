import 'dart:io';
import 'dart:math';

import 'package:dart_application_1/demo_class/class_01.dart';

import '04_function.dart';

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}

/* 
---------Interfaces -------------
Trong Dart, không hỗ trợ đa kế thừa (multiple inheritance) như một số ngôn ngữ khác như C++. Một class chỉ có thể kế thừa từ một class duy nhất. Điều này giúp tránh các vấn đề liên quan đến sự xung đột và không rõ ràng khi một phương thức hoặc thuộc tính nằm trong nhiều class cha khác nhau.

Tuy nhiên, Dart hỗ trợ kế thừa từ nhiều interfaces (interface inheritance). Điều này cho phép một class có thể triển khai nhiều interface và chia sẻ các hành vi từ nhiều nguồn khác nhau. Điều này giúp giải quyết nhu cầu sử dụng các hành vi chung mà không phải kế thừa toàn bộ các thông tin từ một lớp cha duy nhất.

Phương thức trong interface: Tuy thực tế các phương thức trong interface có thể có or ko có body, có thể khai báo properties nhưng để tường minh ko làm rối rắm code ta nên tuân thủ các nguyên tắc chung khi khai báo:
- Định nghĩa interface: Để định nghĩa một interface, bạn sử dụng từ khóa abstract class. Các phương thức trong interface không có phần thân, chỉ có chữ ký (tên và tham số).
- Triển khai interface: Để triển khai một interface trong một class, sử dụng từ khóa implements. Class này phải cung cấp định nghĩa cho tất cả các phương thức được khai báo trong interface. Lưu ý rằng class có thể triển khai nhiều interface cùng một lúc.
*/

abstract class Shape {
  double calculateArea();
}

abstract class Drawable {
  void draw();
}

class Circle implements Shape, Drawable {
  double radius;

  Circle(this.radius);

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }

  @override
  void draw() {
    print("Drawing a circle with radius $radius");
  }
}

void main() {
  Circle circle = Circle(5);
  print("Area of Circle: ${circle.calculateArea()}");
  circle.draw();
}
