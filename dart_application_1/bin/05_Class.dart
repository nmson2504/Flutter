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

// 2- Constructor mặc định (Default Constructor):không có tham số và được tự động tạo khi không khai object
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
}
