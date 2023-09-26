void main() {
  print('Declare multi variables on one line');
  var a = 10, b = 45;
  int so = 120, num = 246;
  print(a);
  print(b);
  print(so);
  print(num);

  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------xxx------------"); // just to show where the cursor is
// http://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
  var numbers = Iterable.generate(10);
  print(numbers);
  print('for...');
  String ch = '';
  for (int i = 0; i < 10; i++) {
    // ch += numbers.elementAt(i).toString() + ' - ';
    ch += '${numbers.elementAt(i)}  - '; // khuyến khích dùng
  }
  print(ch);
  print('forEach...');
  ch = '';
  numbers.forEach((num) {
    ch += '${num}  - '; // khuyến khích dùng
  });
  print(ch);
  print('for...in...');
  ch = '';
  for (var n in numbers) {
    ch += '${n} ';
  }
  print(ch);
  print(numbers.first);
  print(numbers.firstWhere((element) => element > 5));
  print(numbers.firstWhere((element) => element < 5));
  print(numbers.last);
  print(numbers.isEmpty);
  print(numbers.isNotEmpty);
}
