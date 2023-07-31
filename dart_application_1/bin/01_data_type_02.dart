enum Person { son, minh, hung }

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
  list_a.addAll(list_b); // list_b nối vào sau list_a
  print('list_a: ${list_a}');

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
  list_2 = list_1.where((element) => element > 20).toList();
  print('list_2: ${list_2}');
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

// Enumerated types
// Enumerated types, often called enumerations or enums, are a special kind of class used to represent a fixed number of constant values.
  print('-------Enumerated------');
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
  });
}
