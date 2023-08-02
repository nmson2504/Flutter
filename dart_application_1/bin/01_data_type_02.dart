
void main() {
// Collections
//Dart has built-in support for list, set, and map collections. To learn more about configuring the types collections contain, check out Generics.
/* A collection can be empty, or it can contain many elements. Depending on the purpose, collections can have different structures and implementations. These are some of the most common collection types:
List: Used to read elements by their indexes.
Set: Used to contain elements that can occur only once.
Map: Used to read elements using a key. */
//Lists
//Perhaps the most common collection in nearly every programming language is the array, or ordered group of objects. In Dart, arrays are List objects, so most people just call them lists.
// Khai báo mảng kiểu int
  List<int> numbers = [1, 2, 3, 4, 5];
  List<int> numbers_1 = [];

// Khai báo mảng kiểu String
  List<String> names = ['Alice', 'Bob', 'Carol'];

// Khai báo mảng không rõ kiểu dữ liệu (dynamic)
  List fruits = ['Apple', 'Banana', 'Orange'];

// cú pháp rút gọn của List<int>
  var list_1 = [10, 20, 30];
  list_1.forEach((element) => print(element));
  // Add
  print('-------Add------');
  list_1.add(123); // add vào cuối list
  list_1.add(13);
  list_1.add(23);
  list_1.insert(1, 300); // insert vào index chỉ định
  list_1.forEach((element) => print(element));
  // Add list b vào list a
  var list_a = [2, 4, 6, 8];
  var list_b = [1, 3, 5, 7];
  list_a.addAll(
      list_b); // list_b nối vào sau list_a tham số là object Iterable, ko nhận giá trị trực tiếp
  // .addAll nhận vào kiểu Iterable nên để truyền vào 1 list trực tiếp phải đặt trong []
  print('list_a: $list_a');
  list_a.addAll([22, 77]);
  print('list_a.addAll([22, 77]): $list_a');

  // Delete
  print('-------Delete------');
  list_1.remove(
      20); // chỉ định value item - nếu trùng thì chỉ delete first element match
  print(list_1); // print list theo dạng [1, 2, 3,...]
  list_1.removeAt(2); // chỉ định index
  print(list_1);

  list_1.removeLast(); // delete e last
  print('list_1: ${list_1}');

  list_1.removeRange(1, 3); // delete from 1 to 3 (ko xoá index 3)
  print('list_1.removeRange(1,3): ${list_1}');

  list_1.removeWhere(
      (element) => element % 2 != 0); // định nghĩa condition để delete
  print(list_1);
  list_1.clear(); // delete all
  print(list_1);
  // Edit
  print('-------Edit------');
  print(list_1);
  list_1.add(123);
  list_1.add(13);
  list_1.add(9);
  list_1.add(90);
  list_1.add(9);
  list_1.add(0);
  list_1.add(-7);
  list_1[0] = 100;
  // Một số method liên quan
  print(list_1.length);
  print(list_1.first);
  print(list_1.last);
  // kiểm tra
  print('-------kiem tra------');
  print(list_1);
  print(list_1.isEmpty);
  print(list_1.isNotEmpty);
  // any - tồn tại ít nhất 1 element thoã
  print(list_1.any(
    (element) => element > 10,
  ));

  print(list_1.any(
    (element) => element < 10,
  ));
// every - all element thoã
  print(list_1.every((element) => element >= 9));
  print(list_1.every((element) => element <= 9));
  print('-------ttt------');
  print(list_1);
  print(list_1.contains(100)); // kiểm tra x có tồn tại hay ko
  print(list_1.contains(30));

  // lọc ra list con
  List<int> list_2 = [];
  // lọc theo điều kiện
  print('list_1: ${list_1}');
  list_2 = list_1.where((element) => element > 20).toList();
  print('list_2: ${list_2}');
  list_2 = list_1
      .where((element) => element > 20 || element < 10)
      .toList(); // kết hợp điều kiện
  print('list_2 kết hợp ||: ${list_2}');
  list_2 = list_1.where((element) => element.isEven).toList();
  print('list_2 - element.isEven: ${list_2}');
  list_2 = list_1.where((element) => element.isNegative).toList();
  print('list_2 - element.isNegative: ${list_2}');
  // cắt từ index x đến index y
  list_2 = list_1.sublist(2);
  print('list_2: ${list_2}');

  // reverse - đảo ngược list
  list_1.reversed;
  print('list_1.reversed: ${list_1.reversed}');

  // sort
  list_1.sort(); // xếp tăng dần
  print(list_1);
  list_1.sort((a, b) => b.compareTo(a)); // xếp giảm dần
  print(list_1);

  //------------------------
  //Sets
// A set in Dart is an unordered collection of unique items
//Lưu ý rằng tập hợp (set) trong Dart là một tập hợp các phần tử không có thứ tự và không chứa các phần tử trùng lặp. Điều này có nghĩa là, nếu bạn thêm một phần tử đã tồn tại vào tập hợp, nó sẽ không thêm vào lần thứ hai.
  print('-------SET------');
// Khai báo set rỗng
  var emptySet = <String>{};
  var emptySet_1 = Set<String>();
  print('emptySet_1: ${emptySet_1}');
  Set<int> numbers_a = {};
  print('numbers_a: ${numbers_a}');

  // Khai báo và khởi tạo value luôn
  var stringSet = <String>{'mot', 'hai', 'ba'};
  print('stringSet: ${stringSet}');
  var stringSet_1 = Set<String>()..addAll(['apple', 'banana', 'orange']);
  print('stringSet_1: ${stringSet_1}');
  var stringSet_2 = Set<String>.from(['táo', 'chuối', 'cam']);
  print('stringSet_2: ${stringSet_2}');
  Set<int> numbers_k = {10, 7, 9, 23};
  print('numbers_k: ${numbers_k}');
  // Khai báo Set bằng cú pháp Set literals:
  // Luu ý:
  // Cú pháp var ten_bien = {} sẽ return về 1 cấu trúc Map rỗng chứ ko phải là Set
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print('halogens: ${halogens}');

  // Add
  var set_k = {'no', 'mo', 'son'};
  set_k.add('bon');
  print('set_k.add(): ${set_k}');
  /* Trong Dart, Set không hỗ trợ việc chèn phần tử vào một vị trí cụ thể (index) như List. Set là một tập hợp các phần tử không có thứ tự và không chứa các phần tử trùng lặp, vì vậy không có khái niệm vị trí (index) trong Set */
  // Nối 2 set với nhau
  var set_a = {'no', 'mo', 'son'};
  set_a.addAll(halogens); // phải cùng data type
  print('set_a.addAll(halogens): ${set_a}');
// add range qua object Iterable
  Set<int> numbers_m = {10, 7, 9, 23};
  Set<int> numbers_n = {10, 71, 19, 523};
  numbers_m.addAll(numbers_n);
  print('numbers_m.addAll(numbers_n): ${numbers_m}');
// add range trực tiếp
  set_a.addAll(["Carol", "Maven", "Shasha"]);
  print('set_a.addAll(["Carol", "Maven", "Shasha"]);: ${set_a}');
  numbers_n.addAll([50, 30, 78]);
  print('numbers_n.addAll([50, 30, 78]);: ${numbers_n}');

  // Read
  print('-----------------------Set - read--------------');
  print('numbers_n: ${numbers_n}');
  print('numbers_n.first: ${numbers_n.first}');
  print('numbers_n.last: ${numbers_n.last}');

  var kq;
  kq = numbers_n.elementAt(
      3); // *Tuy ko insert qua index được nhưng Set vẫn dùng được index với method .elementAt
  print('kq: ${kq}');

  kq = numbers_n.firstWhere((element) => element == 50); // lọc theo điều kiện
  print(' numbers_n.firstWhere: ${kq}');

  // Edit
  /* giá trị của các phần tử trong Set không thể thay đổi trực tiếp. Set là một tập hợp (collection) không có thứ tự và không chứa các phần tử trùng lặp. Khi một phần tử đã được thêm vào Set, bạn không thể thay đổi giá trị của nó mà phải xóa phần tử cũ và thêm một phần tử mới có giá trị mới vào Set */
  var fruits1 = {'apple', 'banana', 'orange', 'mot', 'hai'};
  print('Set ban đầu: $fruits1');
  fruits1.remove('banana'); // Xóa phần tử cũ 'banana'
  fruits1.add('grape'); // Thêm phần tử mới 'grape' có giá trị mới vào Set
  print('Set sau khi cập nhật: $fruits1');

  fruits1.remove(fruits1.elementAt(1));
  fruits1.add('ABC'); // Thêm phần tử mới 'ABC' có giá trị mới vào Set
  print('fruits1.add(\'ABC\'): ${fruits1}');

  // Delete
  var fruits2 = {
    'apple',
    'banana',
    'orange',
    'water mellon',
    'cherry',
    'orchil'
  };
  print('Set ban đầu: $fruits2');
  fruits2.remove('banana'); // Xóa phần tử chỉ định 'banana'
  print('Set sau khi delete \'banana\': $fruits2');
  fruits2.remove(fruits2.elementAt(1)); // xoá qua index chỉ định
  print('Set sau khi delete elementAt(1): $fruits2');
  fruits2.clear(); // delete all
  print(' fruits2.clear(): ${fruits2}');

  var set_s = {'no', 'mo', 'son', 'ko', 'lo', 'to', 'em'};
  set_s.removeAll({'no', 'em'}); // delete range
  print('set_s.removeAll: ${set_s}');

  // Kiểm tra
  print('\n-----------------------Set - kiem tra--------------');
  print(set_s.any((element) => element == 'mo'));
  print(set_s.every((element) => element == 'mo'));
  print(set_s.contains('lo'));
  print(set_s.containsAll(
      {'lo', 'to'})); // tham số là kiểu Iterable nên phải đặt trong {}

  // lọc ra set con
  print('\n-----------------------Set - lọc ra set con--------------');
  print('set_s: ${set_s}');
  var set_con = set_s.where((element) => element != 'mo');
  print('set_con: ${set_con}');
  set_con = set_s.where((element) =>
      element != 'mo' && element != 'lo'); // kết hợp nhiều điều kiện
  print('set_con: ${set_con}');

// lọc ra elements khác biệt giữa 2 set
  var s1 = {'a', 'b', 'c', 'd', 'e'};
  var s2 = {'d', 'k', 'c', 'm', 'l'};
  set_con = s1.difference(s2); // return elements in s1 && not in s2
  print(' s1.difference(s2): $set_con');

//--------------------------------------
// Enumerated types
//Trong Dart, enum được khai báo ở mức độ của lớp (class), hoặc trong một file riêng biệt. Khai báo enum không được đặt trong hàm hoặc phạm vi khác.
// Enumerated types, often called enumerations or enums, are a special kind of class used to represent a fixed number of constant values.
  Iterable<int> iterable = [1, 2, 3];
  print(' Iterable<int> : ${iterable.runtimeType}');
  Map<String, int> ages1 = {
    "John X": 30,
    "Alice K": 25,
    "Bob C": 28,
  };
  print(' Map<String, int>: ${ages1.runtimeType}');
  enum PersonEnum {
  mot,
  hai,
  ba,
}

  var person = PersonEnum.mot;
  print(person); // Kết quả: Person.mot

  /*  print('\n-------Enumerated------');
  print(Person.hung);
  print(Person.hung.name);
  print(Person.values.length);
  print(Person.values.first);
  print(Person.values.last);
  print(Person.values[0]);
  print(Person.values[Person.values.length - 1]);
  print(Person.minh.index);
  print(Person.values.isEmpty);
  print(Person.values.isNotEmpty);
  //
  Person.values.forEach((el) {
    print('element: ${el.name}');
  }); */
}
