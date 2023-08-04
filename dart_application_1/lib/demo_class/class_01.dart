import 'package:dart_application_1/bin/04_function.dart';

class MyClassA {
  int publicVariable = 10; // Thuộc tính public
  int _privateVariable =
      20; // Thuộc tính private, bắt đầu bằng dấu gạch dưới (_)

  void publicMethod() {
    // Phương thức public
    print("This is a public method.");
    _privateMethod();
  }

  void _privateMethod() {
    // Phương thức private
    print("This is a private method.");
  }
}

//----------------------------
class Animal {
  int foot = 0;
  String eye = 'đen';
  void makeSound() {
    print('Animal makes a sound');
  }

  void run() {
    print('Animal run..........');
  }
}

class Dog extends Animal {
  // Subclass không cho phép run các method build-in như print bên ngoài - phải khai báo method, run trong method
  String long =
      'nâu'; // local variable chỉ được phép khai báo 1 dòng duy nhất, ko cho phép gán lại bên ngoài method

  // các properties của superclass ko truy cập bên ngoài method được

  void dogRun() {
    foot =
        4; // truy cập properties, method của superclass có thể dùng 'super.' or không
    super.eye = 'đỏ';
    run(); //
    print('Dog run - $long - $foot');
  }

  void pS() => print('-----------Dog Start---------');

  // @override - từ khoá @override ko ảnh hưởng gì???
  @override
  makeSound(); // truy cập method superclass ko cần 'super.'

  void pE() => print('--------------Dog End------------');
}

class Animal5 {
  String? name = '';
  int? foot;

  Animal5(this.foot);

  void pMy(name) => print('Animal15 - name: $name');
}

class Dog5 extends Animal5 {
  String breed;

  Dog5(String name, this.breed)
      : super(
            2); // subclass truyền tham số lên cho superclass bằng value/variable qua hàm constructor

  void pS() => print('-----------Dog5 Start---------');

  void pE() => print('--------------Dog5 End------------');
}

class Bird extends Animal {
  // @override
  void makeSound1() {
    print('Chipppppp.............');
  }
}

class Animal3 {
  String name;

  Animal3(this.name);
}

class Dog3 extends Animal3 {
  String breed;

  Dog3(String name, this.breed) : super(name);
}

class Bird2 extends Animal2 {
  @override
  void makeSound() {
    print('Chim2: Chipppppp.............');
    foot = 10;
    print('foot: $foot');
  }
}

/*Trong Dart, bạn có thể sử dụng một lớp làm tham số cho một lớp khác. Điều này cho phép bạn tạo ra các lớp linh hoạt và tái sử dụng code một cách hiệu quả.   */
class Point {
  int x;
  int y;

  Point(this.x, this.y);
  String pP() {
    return '[$x,$y]';
  }
}

class Line {
  Point start;
  Point end;

  Line(this.start, this.end);
  String pLine() {
    return '${start.pP()},${end.pP()}';
  }
}
