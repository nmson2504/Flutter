void main() {
/* FINAL and CONST
https://linhta.dev/blog/final-va-const-trong-dart/#:~:text=const%20phải%20có%20giá%20trị,trị%20với%20object%20ban%20đầu.  

https://www.youtube.com/watch?v=V4t-6A5peA8&list=PL3Ob3F0T-08brnWfs8np2ROjICeT-Pr6T&index=30
  */
  // Lỗi vì không có giá trị khởi tạo khi khai báo biến const - The final variable 'name1' must be initialized.
  const name = 'Bob'; // Without a type annotation
  // const String name1; // Lỗi vì không có giá trị khởi tạo - The constant 'name1' must be initialized.
  final String nickname = 'Bobby';

// Lỗi vì không có giá trị khởi tạo trước khi truy cập biến final - The non-nullable local variable 'nickname1' must be assigned before it can be used.
  final String nickname1; //
  // print('nickname1: $nickname1'); // Lỗi vì không có giá trị khởi tạo - The non-nullable local variable 'nickname1' must be assigned before it can be used.

// Object
// Ko báo lỗi khi viết code, nhưng chạy sẽ báo lỗi - UnsupportedError (Unsupported operation: Cannot modify an unmodifiable list)
  const List list1 = [1, 2, 3];
  // list1[0] = 10;
  // list1.add(4);
  print('list1: ${list1}');

// Object final vẫn có thể thay đổi giá trị được
  final List list2 = [1, 2, 3];
  list2[0] = 10;
  list2.add(4);
  print('list2: ${list2}');

  // Trong Class
  // final person = Person(20); // chỉ có thể gán giá trị 1
  final person = Person();
  person.age = 20;
  // person.name = 'Alice'; // lỗi vì không thể gán lại giá trị của biến final
  print('person: ${person.name} - ${person.age}');

  var animal = Animal(); // lỗi vì không thể gán lại giá trị của biến const
  // animal.name = 'Boby';
  print('animal: ${Animal.name}');

  // khai báo object const

  const hanoi = Capital("Hanoi"); // cả object và constructor đều là const
  print('hanoi: ${hanoi.name}');

  var vietnam = const Country("Viet Nam", capital: hanoi); // object ko là const
  print('${vietnam.name} - ${vietnam.capital.name}'); // Hanoi
}

class Person {
  final String name = 'Bob';
  late final int age;

  /// Nếu khai báo final ko khởi tạo giá trị, thì phải khởi tạo giá trị bằn hàm khởi tạo (vdu: Person(this.age);) hoặc dùng từ khoá late
  // Person(this.age);
}

// const - ko thể thay đổi giá trị
class Animal {
  static const String name =
      'Boby'; // phải dùng từ khoá static và khởi tạo giá trị
}

/// Flutter khuyến khích dùng const widget bất cứ khi nào có thể bởi khi hàm build được gọi, các const widget sẽ không bị rebuild, giúp cải thiện hiệu năng đáng kể
class Capital {
  final String name;

  const Capital(this.name); // const constructor
}

class Country {
  final Capital capital;
  final String name;

  const Country(this.name, {required this.capital}); // const constructor
}
