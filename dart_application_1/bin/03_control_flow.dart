import '../lib/dart_application_1.dart';

void main() {
// COLTROL FLOW
// for loop
  var message = StringBuffer('Dart is fun');
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }
  print('message: ${message}');

  var callbacks = [];
  for (var i = 0; i < 9; i++) {
    callbacks.add(i);
  }
  print('callbacks: ${callbacks}');

  //
  List arr = [1, 10, 'a', 123, 30, 'b', 'df', 89, 'nms'];
  for (var i = 0; i < arr.length; i++) {
    if (arr[i] is num) print('arr[$i]: ${arr[i]}');
  }

// for - in
/* Vòng lặp for...in trong Dart được sử dụng khi bạn muốn lặp qua tất cả các phần tử của một tập hợp (collection) cụ thể, chẳng hạn như List, Set, Map hoặc Iterable. Vòng lặp này thường dùng để duyệt qua các phần tử một cách đơn giản và dễ đọc hơn so với việc sử dụng các chỉ số như vòng lặp for thông thường. */

  List<int> numbers = [1, 2, 3, 4, 5];
  print("Duyệt qua danh sách số:");
  for (var number in numbers) {
    print(number);
  }
  // Output:
  // 1
  // 2
  // 3
  // 4
  // 5

  Set<String> fruits = {"Apple", "Banana", "Orange"};
  print("Duyệt qua tập hợp các loại hoa quả:");
  for (var fruit in fruits) {
    print(fruit);
  }
  // Output:
  // Apple
  // Banana
  // Orange

  Map<String, int> ages = {
    "John": 30,
    "Alice": 25,
    "Bob": 28,
  };
  print("Duyệt qua các cặp tên và tuổi trong bản đồ:");
  for (var entry in ages.entries) {
    print("${entry.key}: ${entry.value}");
  }
  // Output:
  // John: 30
  // Alice: 25
  // Bob: 28

// forEach()
/* Phương thức forEach trong Dart được sử dụng để duyệt qua tất cả các phần tử của một tập hợp (collection) và thực hiện một hành động cụ thể trên từng phần tử. Điểm đặc biệt của forEach là nó không trả về giá trị và không thể dừng hoặc bỏ qua các phần tử trong tập hợp như vòng lặp for...in. */

  List<int> numbers1 = [10, 20, 30, 40, 5];
  print("Duyệt qua danh sách số và in giá trị:");
  numbers1.forEach((number) {
    print(number);
  });

  Set<String> fruits1 = {"Apple", "Banana", "Orange", 'Watter Balon'};
  print("Duyệt qua tập hợp các loại hoa quả và in tên:");
  fruits1.forEach((fruit) {
    print(fruit);
  });

  Map<String, int> ages1 = {
    "John X": 30,
    "Alice K": 25,
    "Bob C": 28,
  };
  print("Duyệt qua các cặp tên và tuổi trong bản đồ và in thông tin:");
  ages1.forEach((name, age) {
    print("$name: $age tuổi");
  });

// WHILE
  int n = 0;
  int sum = 0;
  while (n < 10) {
    sum += n;
    n++;
  }
  print("Tổng các số từ 1 đến $n là: $sum");

// DO WHILE
  do {
    print('n: ${n}');
    n--;
  } while (n != 0);

// Break and continue
// Use break to stop looping:
  while (n < 10) {
    print('n <= 5: ${n}');
    if (n == 5) break;
    n++;
  }

// Use continue to skip to the next loop iteration:
  List<dynamic> dynamicList = [1, "Hello", true, 3.14];
  // Sử dụng danh sách động kiểu 'dynamic'
  for (var item in dynamicList) {
    if (item.runtimeType == bool) {
      continue;
    }
    print("List - Item: $item, Type: ${item.runtimeType}");
  }

// If
/* Dart supports if statements with optional else clauses. The condition in parentheses after if must be an expression that evaluates to a boolean: */
  int age = 25;
  if (age < 30) {
    print('tuoi ban < 30');
  }
  //
  if (age >= 18) {
    print("Bạn đã đủ tuổi để bỏ phiếu.");
  } else {
    print("Bạn chưa đủ tuổi để bỏ phiếu.");
  }

// if lồng if
  if (age >= 18) {
    print('đủ tuổi thành niên.');
  } else if (age < 50 && age >= 18) {
    print('trung nien');
  }
//
  var diem = 9;
  if (diem < 5) {
    print('yếu.');
  } else if (diem >= 5 && diem < 7) {
    print('trun bình');
  } else if (diem >= 7 && diem < 9) {
    print('khá.');
  } else {
    print('giỏi!');
  }

  // clear(); //import '../lib/dart_application_1.dart';
// Switch statements
  age = 20;
  String status;
  switch (age) {
    case 18:
      status = "Bạn đã đủ tuổi bầu cử.";
    case > 18:
      status = "Bạn đã đủ tuổi uống rượu.";
    default:
      if (age > 21) {
        status = "Bạn đã đủ tuổi làm mọi thứ.";
      } else {
        status = "Bạn chưa đủ tuổi làm mọi thứ.";
      }
  }
  print(status);
  // với keyword 'break' - ko co break vẫn dừng lại tại case match. Tại sao???
  int day = 1;
  String dayName;
  switch (day) {
    case 1:
      dayName = "Thứ Hai";
    //  break;
    case 2:
      dayName = "Thứ Ba";
    // break;
    case 3:
      dayName = "Thứ Tư";
    //  break;
    default:
      dayName = "Không xác định";
    //  break;
  }
  print(dayName);
}
