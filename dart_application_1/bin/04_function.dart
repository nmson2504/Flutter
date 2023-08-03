void main() {
  inMsg();
  var tong = sum2Digit(10, 55);
  print('tong: ${tong}');

  var m = multiply(4, 2.5);
  print('m: ${m}');

// lambda
  greeting(); // call Function Expression định nghĩa trước
  (() => print("This is an anonymous function."))(); // thực thi hàm trực tiếp

// Higher-Order Function
  exeFunction(() {
    print('alllllllllllllllllllllllllll');
  });

  clearScreen();

  // tham số option []
  printNum(10);
  printNum(10, 5);
  printNum(10, 5, 30);

  // "Function with Named Parameters" (Hàm có Tham số Đặt tên).
  greet(name: 'NMSON', age: 50);
  // call lại, đảo vị trí tham số
  greet(age: 27, name: 'Lê Công');
  // có thể ko truyền tham số - lấy values default
  greet(age: 47);

  // required
  printPersonInfo(name: 'Lê Anh Tùng', age: 120);
}

//------FUNCTION------------
// 1- Khai báo thông thường
void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------VAR------------"); // just to show where the cursor is
}

void inMsg() {
  print('Helooooooo!');
}

int sum2Digit(int a, int b) {
  return a + b;
}

// 2- Khai báo hàm ngắn gọn (Expression function):
//Trong trường hợp hàm chỉ có một câu lệnh trả về giá trị, bạn có thể sử dụng cú pháp ngắn gọn.
num multiply(num a, num b) => a * b;

// 3- Khai báo hàm lambda (Anonymous function):
// Hàm lambda là một hàm không tên, có thể được gán vào biến hoặc sử dụng trực tiếp.
// Khai báo hàm lambda và gán vào biến
var greeting = () => print("Hello, world!");

// 4 - Khai báo hàm như tham số (Higher-Order Function):
// Trong Dart, hàm có thể được truyền như một tham số cho hàm khác.
void exeFunction(Function function) {
  function();
}

//
//-----------Parameter----------------
// tham số option, đặt trong []
void printNum(int a, [int? b, int? c]) {
  print("$a - $b - $c ");
}

// Đặt tên tham số - "Function with Named Parameters" (Hàm có Tham số Đặt tên).
// Khi gọi "Function with Named Parameters" thì ko cần quan tâm thứ tự các tham số.
// Có thể ko truyền tham sô như trường hợp option parameter []
// ký tự '=' là gán value default
void greet({String name = 'Guess', int age = 0}) {
  print("Hello, $name! You are $age years old.");
}

// Từ khóa required trước tên của tham số. Khi một tham số được đánh dấu là required, khi gọi hàm, bạn phải cung cấp giá trị cho tham số đó, không thể bỏ qua.
void printPersonInfo({required String name, required int age}) {
  print("Name: $name, Age: $age");
}
