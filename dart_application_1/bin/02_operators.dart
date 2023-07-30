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
}
