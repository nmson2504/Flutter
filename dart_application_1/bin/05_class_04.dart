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
