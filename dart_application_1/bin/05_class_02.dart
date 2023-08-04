import 'package:dart_application_1/demo_class/class_01.dart';

import '04_function.dart';

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}

/* 
---------Extends - Override - Super -------------
 */
void main() {
  Bird chim = Bird();
  chim.makeSound();

  print('-----------------');

  Dog bull = Dog();
  bull.pS();
  bull.run();
  bull.makeSound();

  // class ko khai báo 2 method get - set - vẫn có thể truy cập properties bình thường
  bull.foot = 22;
  print('bull.foot: ${bull.foot}');
  bull.dogRun();
  bull.pE();
  //
  Bird2 chim_2 = Bird2();
  chim_2.makeSound();
  chim_2.foot = 20;
  print('chim_2.foot: ${chim_2.foot}');

//
  Dog5 dog5 = Dog5('Ghẻ lác', 'xù xám');
  dog5.pS();
  print('dog5: ${dog5.name} - ${dog5.breed} - ${dog5.foot}');
  dog5.pE();

  // class làm tham số cho class khác

  Line line_1 = Line(Point(5, 6), Point(3, 1));
  print('line_1: ${line_1.pLine()}');

  /* Trong Dart, không hỗ trợ đa kế thừa (multiple inheritance) như một số ngôn ngữ khác như C++. Một class chỉ có thể kế thừa từ một class duy nhất. Điều này giúp tránh các vấn đề liên quan đến sự xung đột và không rõ ràng khi một phương thức hoặc thuộc tính nằm trong nhiều class cha khác nhau.

Tuy nhiên, Dart hỗ trợ kế thừa từ nhiều interfaces (interface inheritance). Điều này cho phép một class có thể triển khai nhiều interface và chia sẻ các hành vi từ nhiều nguồn khác nhau. Điều này giúp giải quyết nhu cầu sử dụng các hành vi chung mà không phải kế thừa toàn bộ các thông tin từ một lớp cha duy nhất. */
}
