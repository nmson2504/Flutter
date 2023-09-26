void main() {
  // OPERATORS
  // Divide
  // Chia tự nhiên - lấy luôn decimal
  print(5 / 2);
  // Chia lấy số nguyên
  print(5 ~/ 2);
  // Chia lấy số dư (modulo)
  print(5 % 2);

  //------------------
  // Type test
  // IS oprerator
  dynamic value = "Hello";

  if (value is String) {
    print("Biến 'value' thuộc kiểu String.");
  } else {
    print("Biến 'value' không thuộc kiểu String.");
  }
  // Output: Biến 'value' thuộc kiểu String.

  if (value is int) {
    print("Biến 'value' thuộc kiểu int.");
  } else {
    print("Biến 'value' không thuộc kiểu int.");
  }
  // Output: Biến 'value' không thuộc kiểu int.

// IS! operator
  dynamic var01 = "Hello";

  if (var01 is! String) {
    print("Biến 'value' ko thuộc kiểu String.");
  } else {
    print("Biến 'value' thuộc kiểu String.");
  }
  // Output: Biến 'value' thuộc kiểu String.

  if (var01 is! int) {
    print("Biến 'value' ko thuộc kiểu int.");
  } else {
    print("Biến 'value' thuộc kiểu int.");
  }
  // Output: Biến 'value' không thuộc kiểu int.
//-----------------------------------
// Assignment operators
// ??= --> chỉ gán nếu variable là null
  var m;
  m ??= 100;
  print('m: ${m}');
  m ??= 123;
  print('m: ${m}');

// Conditional expressions
// condition ? expr1 : expr2
// If condition is true, evaluates expr1 (and returns its value); otherwise, evaluates and returns the value of expr2.
  var flag = false;
  var visibility = flag ? 'public' : 'private';
  print('visibility: ${visibility}');

  //expr1 ?? expr2
// If expr1 is non-null, returns its value; otherwise, evaluates and returns the value of expr2.
  var var02;
  var var03 = 324;
  var kq = var02 ?? var03;
  print('kq: ${kq}');
  var kq1 = var03 ?? var02;
  print('kq1: ${kq1}');

// Ký hiệu .. trong Dart được gọi là Dart Cascade Notation hoặc Cascade Operator.
// Nó là một tính năng mạnh mẽ của ngôn ngữ Dart, cho phép bạn gọi nhiều phương thức trên cùng một đối tượng mà không cần viết lại tên đối tượng nhiều lần.
// Vd1:
  List<dynamic> ls = [];
  // ko dùng ..
  ls.add(10);
  ls.add(30);
  // dùng ..
  ls
    ..add(40)
    ..add(50);
  print('ls: $ls');

  // Vd2
  ls
    ..addAll([2, 4, 6, 8])
    ..removeWhere((element) => element > 30);
  print('ls: $ls');
}
