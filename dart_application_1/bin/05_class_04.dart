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

/* Mixin là một lớp mà không thể tạo thể hiện (instance) từ đó, nhưng bạn có thể sử dụng nó để thêm các chức năng vào các lớp khác. Mixin chứa các phương thức và thuộc tính mà bạn muốn tái sử dụng trong nhiều lớp.
Trong Dart, bạn có thể sử dụng từ khóa mixin để định nghĩa một mixin. Để sử dụng mixin trong một lớp, bạn sử dụng từ khóa with sau tên của lớp và theo sau là tên của mixin.
 
 Một lớp chỉ có thể kế thừa từ một lớp cha duy nhất, nhưng có thể sử dụng nhiều mixins. Khi một lớp sử dụng nhiều mixins, mixin được khai báo đầu tiên sẽ có ưu tiên cao nhất, sau đó là mixin thứ hai, và tiếp tục như vậy.

Mixin không thể khai báo các hàm tạo (constructor) sinh ra các thể hiện (instance), nhưng có thể chứa các hàm tạo static. Nếu mixin chứa các phương thức trừu tượng, lớp sử dụng mixin phải cung cấp định nghĩa cho các phương thức này.
Mixin có thể được áp dụng không chỉ cho các lớp, mà còn cho các interface.
* Cú pháp ko bắt buộc khai báo mixin trên các class được with (class thường hay abstract cũng được) nhưng nên sử dụng từ khoá mixin tường minh để quản lý code chặt chẽ hơn.
 */
mixin Musical {
  void playMusic() {
    print("Playing music");
  }
}

class Performer with Musical {
  void perform() {
    playMusic();
    print("Performing on stage");
  }
}

/* mixin nhiều class
Nếu trùng method, properties thì sẽ ghi đè - show kết quả của mixin cuối cùng
 */
mixin MusicalMixinA {
  int m = 10;
  void playMusic() {
    print("Playing music");
  }
}
mixin MusicalMixinB {
  int m = 100;
  void playMusic() {
    print("Playing music MusicalMixinB");
  }
}

class Singer with MusicalMixinA, MusicalMixinB {
  void sing() {
    print("Singing a song Singer $m");
  }
}

/* Cú pháp extends kết hợp với with được sử dụng trong Dart để chỉ định một class con kế thừa từ một lớp cha và sử dụng mixin để thêm các tính năng từ các mixin class khác.
Cú pháp chung:
class ChildClass extends ParentClass with Mixin1, Mixin2, ... {
  // Các phần thân của class con
}
Trong đó:
ChildClass là tên của class con mà bạn đang định nghĩa.
ParentClass là tên của lớp cha mà ChildClass kế thừa.
Mixin1, Mixin2, ... là các mixin class mà bạn muốn sử dụng để thêm các tính năng bổ sung vào ChildClass.
Ví dụ:
Trong ví dụ trên, class Performer kế thừa từ class Person và sử dụng các mixin Musical và Dancer để thêm các tính năng playMusic() và dance(). Performer có thể sử dụng tất cả các phương thức từ class cha và các mixin để thực hiện nhiều hoạt động khác nhau.
 */
mixin Musical1 {
  void playMusic() {
    print("Playing music");
  }
}

mixin Dancer {
  void dance() {
    print("Dancing");
  }
}

class Performer1 extends Person with Musical1, Dancer {
  Performer1(String name)
      : super(name); // bắt buộc cung cấp tham số cho constructor của superclass

  void perform() {
    playMusic(); // call method mixin
    dance(); // call method mixin
    print("Performing1 on stage");
  }
}

class Person {
  String name;
  Person(this.name);
  void talk() {
    print('person talk...........');
  }
}

/* Đôi khi bạn có thể muốn định nghĩa 1 mixin mà giới han các class khác mixin tới nó, dưới đây là cách thực hiện
- 1. mixin Class_mixin on Class_super
- 2. Class_sub extend Class_super with Class_mixin
--> Chỉ mixin được Class_mixin thông qua extend Class_super
 */
mixin MusicalMixin on PerformerA {
  void playMusic() {
    print("Playing music");
  }
}
mixin MusicalMixin2 {
  void playMusic() {
    print("Playing music MusicalMixin2");
  }
}

class PerformerA {
  void perform() {
    print("Performing on stage");
  }
}

class SingerM extends PerformerA with MusicalMixin {
  void sing() {
    print("Singing a song Singer");
  }
}

/* 
abstract mixin class
You can achieve similar behavior to the on directive for a mixin class. Make the mixin class abstract and define the abstract methods its behavior depends on:
 */
abstract mixin class Musician {
  // No 'on' clause, but an abstract method that other types must define if
  // they want to use (mix in or extend) Musician:
  void playInstrument(String instrumentName);

  void playPiano() {
    playInstrument('Piano');
  }

  void playFlute() {
    playInstrument('Flute');
  }
}

class Virtuoso with Musician {
  // Use Musician as a mixin
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }
}

class Novice extends Musician {
  // Use Musician as a class
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }
}

/* Trong Dart, extension là một cơ chế cho phép bạn thêm các phương thức và thuộc tính mới vào các lớp đã tồn tại mà bạn không thể sửa đổi. Điều này giúp bạn mở rộng chức năng của các lớp mà không cần phải kế thừa từ chúng hoặc chỉnh sửa chúng trực tiếp. Extension giúp tách biệt logic mở rộng ra khỏi lớp gốc, đồng thời giữ cho mã dễ đọc và bảo trì hơn.

Dưới đây là cú pháp cơ bản của cách định nghĩa một extension trong Dart:
extension ExtensionName on ExtendedType {
  // Các phương thức và thuộc tính mới ở đây
}
Vidu
extension IntExtension on int {
  int squared() {
    return this * this;
  }
}
-- sử dụng
void main() {
  int number = 5;
  print(number.squared()); // Output: 25
}
---------------
extension cũng có thể áp dụng trên các class tự định nghĩa.
Lưu ý rằng extension chỉ có thể thêm phương thức và thuộc tính mới mà không thay đổi cấu trúc dữ liệu bên trong lớp gốc. Bạn không thể sửa đổi các thành phần riêng tư (private) hoặc bảo vệ (protected) bằng extension.
Extension là một tính năng mạnh mẽ trong Dart giúp bạn tách biệt chức năng mở rộng từ các lớp gốc, đảm bảo tính linh hoạt và bảo trì trong mã của bạn.
 */

void main() {
  var performer = Performer();
  performer.perform();

  // extend kết hợp mixin
  var performer1 = Performer1("Alice");
  performer1.perform();
  performer1.talk();

  Circle circle = Circle(5);
  print("Area of Circle: ${circle.calculateArea()}");
  circle.draw();
}
