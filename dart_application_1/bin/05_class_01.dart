import 'package:dart_application_1/demo_class/class_01.dart';

import '04_function.dart';

void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}

/* Quy tắc đặt tên
 - File name .dart, ... chữ thường
 - Class name: viết hoa ký tự đầu mỗi từ theo quy tắc Camel 
 */
class Person {
  // properties
  String name;
  int age;

  // contructor
  // có thể áp dụng các từ khoá ?, [], {}, =, required như cách định nghĩa hàm thông thường (phải setup cú pháp lại cho phù hợp với từng trường hợp)
  Person(this.name,
      this.age); // cách này yêu cầu phải truyền đầy đủ tham số khi khởi tạo object

  // methods
  void sayHello() {
    print("Hello, my name is $name.");
  }

  void celebrateBirthday() {
    age++;
    print("Happy birthday to me! Now I am $age years old.");
  }
}

// MỘT SỐ CÁCH SETUP CÚ PHÁP CHO HÀM CONTRUCTOR
/* Từ khóa late trong Dart được sử dụng để khai báo một biến có thể được trì hoãn (deferred) việc khởi tạo giá trị cho đến khi nó thực sự được sử dụng. Biến được khai báo với từ khóa late phải là biến thành viên (instance variable) trong một class.v
Điểm chính khi sử dụng late là giúp bạn tạo ra các biến mà giá trị của chúng chỉ được tính toán hoặc khởi tạo sau khi đối tượng được tạo, và do đó giảm thiểu việc khởi tạo không cần thiết, giúp tối ưu hiệu năng. */
// 1-  Person(this.name,this.age); ở trên - cách rút gọn, yêu cầu phải truyền đủ tham số

// 2- Constructor mặc định (Default Constructor):không có tham số và được tự động tạo khi khai báo object
class Person_a {
  // properties
  String? name;
  int? age;

  // contructor
  // có thể áp dụng các từ khoá ?, [], {}, =, required như cách định nghĩa hàm thông thường (phải setup cú pháp lại cho phù hợp với từng trường hợp)
  Person_a() {
    name = 'Unknow';
    age = 0;
  }
  // methods
  void sayHello() {
    print("Hello, my name is $name.");
  }

  void celebrateBirthday() {
    //age++;
    print("Happy birthday to me! Now I am $age years old.");
  }
}
// Trường hợp tương tự: class ko định nghĩa constructor - khi khai báo insctance vẫn dùng cú pháp như trường hợp (2) này. Vd:  MyClassC classC = MyClassC();

// 3- Constructor có tham số (Parameterized Constructor):
class Person_b {
  // properties

  late String
      name; // late - ko báo lỗi Non-nullable instance field 'name' must be initialized.
  late int age;

  // contructor
  // có thể áp dụng các từ khoá ?, [], {}, =, required như cách định nghĩa hàm thông thường (phải setup cú pháp lại cho phù hợp với từng trường hợp)
  Person_b(String name, int age) {
    this.name = name;
    this.age = age;
  } // cách này yêu cầu phải truyền đầy đủ tham số khi khởi tạo object

  // methods
  void sayHello() {
    print("Hello, my name is $name.");
  }

  void celebrateBirthday() {
    age++;
    print("Happy birthday to me! Now I am $age years old.");
  }
}

// 4- Constructor có tham số đặt tên (Named Constructor):Constructor có tham số đặt tên là constructor mà bạn tự định nghĩa và được gọi bằng tên được xác định trước.
// (truyền vào nhiều giá trị default cho các Names Constructor khác nhau)
class Person_c {
  late String name;
  late int age;

  // Constructor mặc định
  Person_c(this.name, this.age);

  // Named constructor
  Person_c.guest() {
    name = "Guest";
    age = 0;
  }
  Person_c.admin() {
    name = "Admin";
    age = 100;
  }

  void sayHello() {
    print("Hello, my name is $name. I am $age years old.");
  }
}

// Phạm vi truy cập
/* Phạm vi truy cập public, private trong class của Dart là một khái niệm liên quan đến tính đóng gói (encapsulation) trong lập trình hướng đối tượng. Phạm vi truy cập cho biết mức độ hiển thị và sử dụng của các thuộc tính và phương thức trong một class đối với các đối tượng khác. Dart có hai loại phạm vi truy cập chính là public và private1.

- public: có thể truy cập từ bất kỳ đâu, bao gồm bên trong class, bên ngoài class, trong cùng package hoặc khác package. Các thuộc tính và phương thức khai báo public thì có thể được truy cập trực tiếp thông qua instance của class đó. Để khai báo một thành phần là public, chỉ cần đặt tên cho nó mà không cần thêm ký tự gạch dưới (_) ở đầu.
- private: chỉ được truy cập từ bên trong class chứa thuộc tính hoặc phương thức đó. Các thuộc tính và phương thức khai báo private thì không thể được truy cập bởi các function, class khác. Để khai báo một thành phần là private, sử dụng ký tự gạch dưới (_) ở đầu tên của nó.  
Định nghĩa class và lệnh khai báo instance của class trong cùng file - private ko có tác dụng.
Định nghĩa class ở file .dart khác: private có tác dụng
  - Cùng folder file khai báo instance: phải import file (VS Code import tự động)
  - Khác folder file khái báo instance: phải import file

// Để truy cập các properties private cửa class từ bên ngoài ta định nghĩa 2 method get & set như sau  
//Getter public cho thuộc tính private
  int get privateVariable => _privateVariable;

  // Setter public cho thuộc tính private
  set privateVariable(int newValue) {
    _privateVariable = newValue;
  }
*/

class MyClass {
  int publicVariable = 10; // Thuộc tính public
  int _privateVariable = 20; // thuộc tính private bắt đầu bằng dấu _
  get privateVariable => this._privateVariable;

  set privateVariable(value) => this._privateVariable = value;

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

void main() {
  Person person_1 = Person('nmson', 90);
  person_1.sayHello();
  person_1.celebrateBirthday();

  Person_a p2 = Person_a();
  p2.celebrateBirthday();

  Person_b p3 = Person_b('Trần Minh', 58);
  p3.sayHello();

  // Gọi constructor mặc định
  Person_c person1 = Person_c('Alice', 30);
  person1.sayHello(); // Kết quả: "Hello, my name is Alice. I am 30 years old."

  // Gọi named constructor
  Person_c person3 = Person_c.admin();
  person3.sayHello(); // Kết quả: "Hello, my name is Alice. I am 30 years old."

  Person_c person2 = Person_c.guest();
  person2.sayHello(); // Kết quả: "Hello, my name is Guest. I am 0 years old."

  clearScreen();
  // Phạm vi truy cập
  MyClass myClass = MyClass();
  myClass._privateMethod();
  myClass.publicMethod();
  print(
      '${myClass._privateVariable}'); // trong cùng file vẫn truy cập được ( ký hiệu _ private ko tác dụng)

// import 'package:dart_application_1/demo_class/class_01.dart';
// file .dart trong folder khac - phai import
  MyClassA classA = MyClassA();
  // print('classA.privateVariable: ${classA.privateVariable}');

// file .dart cung folder - VS Code import tự động
// Van bi gioi han truy cap muc private
  print('-----------classC----------');
  MyClassC classC = MyClassC();
  classC.publicMethod();

  print('classC.privateVariable: ${classC.privateVariable}');
  classC.privateVariable = 120;
  print('classC.privateVariable: ${classC.privateVariable}');
}
