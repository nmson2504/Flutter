import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MyConst extends StatelessWidget {
  const MyConst({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Const Constructor')),
        body: const MyWidget2(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

/* 
Một số lưu ý khi triển khai const constructor

 */
// StatelessWidget
class MyWidget1 extends StatelessWidget {
  // Only static fields can be declared as const.
  // All variables must be initialized with final, static, static const, static final
  final int a = 3;
  static final ValueNotifier<int> remainingSeconds = ValueNotifier(60);
  static int b =
      5; //  thuộc tính static có thể được khởi tạo và thay đổi sau khi khởi tạo.
  static const int c =
      10; // Only static fields can be declared as const. static const được khởi tạo và ko thể thay đổi sau khi khởi tạo.

  const MyWidget1({super.key});
  // Only static fields can be declared as const.
  // Getters, setters and methods can't be declared to be 'const'.
// Methods chỉ khai báo đươc với non or static
  void methodA() {
    debugPrint('methodA');
  }

  static void methodB() {
    debugPrint('static void methodB');
  } // method ko khai bao voi keyword final duoc

  int methodD() {
    return a * b;
  }

// Static methods chỉ truy cập được static fields
  static int methodC() {
    return c + b; // Instance members can't be accessed from a static method.
  } // method ko khai bao voi keyword final duoc

  @override
  Widget build(BuildContext context) {
    methodA();
    methodB();

    debugPrint(methodC().toString());
    debugPrint(methodD().toString());

    return const Placeholder();
  }
}

// StatefulWidget
/* 
Trong Dart, bạn có thể khai báo các fields với cùng tên trong class mẹ (StatefulWidget) và class con (State). Tuy nhiên, các fields này không thực sự "trùng" vì chúng thuộc về hai class khác nhau. Cụ thể:

 - Fields trong StatefulWidget: Thuộc về class StatefulWidget. Những fields này có thể được sử dụng khi bạn cần truyền dữ liệu từ widget gốc vào State.

 - Fields trong State: Thuộc về class State liên kết với StatefulWidget. Các fields này chỉ tồn tại trong state và có thể thay đổi trong vòng đời của widget.
 
 Trong class MyWidget2 (StatefulWidget):
final int a = 10;
Field này tồn tại trong MyWidget2 và có thể được truy cập qua widget.a từ trong State object (_MyWidget2State).

 Trong class _MyWidget2State (State):
final int a = 10;
Field này tồn tại trong _MyWidget2State và chỉ có thể được truy cập trong phạm vi của class _MyWidget2State.
 */

class MyWidget2 extends StatefulWidget {
  const MyWidget2({super.key});
  static final ValueNotifier<int> remainingSeconds = ValueNotifier(60);
  final int a = 10;
  final int a1 = 100;
  static const int b = 22;
  static int m = 10;

  @override
  State<MyWidget2> createState() => _MyWidget2State();
}

class _MyWidget2State extends State<MyWidget2> {
  // tại đây (_MyWidget2State) cho phép khai báo fields trơn ko từ khoá
  final ValueNotifier<bool> isSubmitted = ValueNotifier(false);
  TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameController2 = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  final int a = 33;
  final int a1 = 3;
  static const int b = 12;
  static int m = 40;
  int x = 123;
  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Widget a1: ${widget.a1}'); // Sử dụng field non static từ MyWidget2
    debugPrint(
        'Widget B: ${MyWidget2.b}'); // truy cập static field từ MyWidget2
    debugPrint('State b: $b'); // Sử dụng field 'b' từ _MyWidget2State
    debugPrint('State a1: $a1'); // Sử dụng field 'b' từ _MyWidget2State
    debugPrint('State x: $x'); // Sử dụng field 'b' từ _MyWidget2State
    debugPrint('State m: $m'); // Sử dụng field 'b' từ _MyWidget2State
    return const Placeholder();
  }
}
