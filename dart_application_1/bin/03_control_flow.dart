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
}
