import 'package:flutter/material.dart';

class MyAppInheritedNotifier extends StatelessWidget {
  const MyAppInheritedNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InheritedNotifier Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterPage2(),
    );
  }
}

// Example 1
// khai báo CounterNotifier extends ValueNotifier<int>
/* 
CounterProvider bao bọc xung quanh cây widget (Scaffold và các widget con của nó).
_counterNotifier được truyền vào CounterProvider để các widget con có thể sử dụng nó.
 */
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterNotifier _counterNotifier = CounterNotifier();

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      notifier: _counterNotifier,
      child: Scaffold(
        appBar: AppBar(title: const Text('InheritedNotifier Counter')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterDisplay(),
              SizedBox(height: 20),
              CounterIncrementButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// lớp Notifier (Có thể sử dụng ValueNotifier hoặc ChangeNotifier tùy thuộc vào yêu cầu của ứng dụng.)
/* Lớp này chịu trách nhiệm quản lý trạng thái của dữ liệu và thông báo cho các widget con mỗi khi dữ liệu thay đổi.  */
class CounterNotifier extends ValueNotifier<int> {
  CounterNotifier() : super(0);
// giá trị của counter được tăng lên và các widget con sẽ được thông báo.
  void increment() {
    value++;
  }
}

// Lớp kế thừa từ InheritedNotifier
/* Lớp này sẽ wrap cây widget để cung cấp dữ liệu (notifier) cho các widget con thông qua context. Đây là lớp chính giúp các widget con có thể truy cập vào Notifier.
 */
class CounterProvider extends InheritedNotifier<CounterNotifier> {
  const CounterProvider({
    super.key,
    required CounterNotifier super.notifier,
    required super.child,
  });
// Phương thức of cho phép các widget con truy cập vào CounterNotifier thông qua context.
  static CounterNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!.notifier!;
  }
}

/* 
Sử dụng Notifier trong các widget con
Các widget con có thể truy cập vào Notifier bằng cách sử dụng phương thức of trong CounterProvider. Dữ liệu trong Notifier có thể được hiển thị và tương tác từ các widget con.
Để hiển thị dữ liệu từ Notifier, bạn có thể sử dụng ValueListenableBuilder hoặc AnimatedBuilder.
 */
// ValueListenableBuilder lắng nghe thay đổi từ counter và cập nhật giao diện khi giá trị thay đổi.
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = CounterProvider.of(context);
    return ValueListenableBuilder<int>(
      valueListenable: counter,
      builder: (context, value, child) {
        return Text(
          'Count: $value',
          style: Theme.of(context).textTheme.labelMedium,
        );
      },
    );
  }
}

//  phương thức increment của CounterNotifier được gọi và dữ liệu được cập nhật.
class CounterIncrementButton extends StatelessWidget {
  const CounterIncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        CounterProvider.of(context).increment();
      },
      child: const Text('Increment'),
    );
  }
}

// Example 2
// khai báo CounterNotifier extends ChangeNotifier
/* 
CounterProvider bao bọc xung quanh cây widget (Scaffold và các widget con của nó).
_counterNotifier được truyền vào CounterProvider để các widget con có thể sử dụng nó.
 */
class CounterPage2 extends StatefulWidget {
  const CounterPage2({super.key});

  @override
  State<CounterPage2> createState() => _CounterPage2State();
}

class _CounterPage2State extends State<CounterPage2> {
  final CounterNotifier2 _counterNotifier = CounterNotifier2();
//  Now includes a dispose() method to properly dispose of the CounterNotifier when the widget is removed from the tree.
  @override
  void dispose() {
    _counterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider2(
      notifier: _counterNotifier,
      child: Scaffold(
        appBar: AppBar(title: const Text('InheritedNotifier 2 Counter')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterDisplay2(),
              SizedBox(height: 20),
              CounterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

// lớp Notifier (Có thể sử dụng ValueNotifier hoặc ChangeNotifier tùy thuộc vào yêu cầu của ứng dụng.)
/* Lớp này chịu trách nhiệm quản lý trạng thái của dữ liệu và thông báo cho các widget con mỗi khi dữ liệu thay đổi.  */
class CounterNotifier2 extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
}

// Lớp kế thừa từ InheritedNotifier
/* Lớp này sẽ wrap cây widget để cung cấp dữ liệu (notifier) cho các widget con thông qua context. Đây là lớp chính giúp các widget con có thể truy cập vào Notifier.*/
class CounterProvider2 extends InheritedNotifier<CounterNotifier2> {
  const CounterProvider2({
    super.key,
    required CounterNotifier2 notifier,
    required super.child,
  }) : super(notifier: notifier);
// Phương thức of cho phép các widget con truy cập vào CounterNotifier thông qua context.
  static CounterNotifier2 of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider2>()!.notifier!;
  }
}

/* 
Sử dụng Notifier trong các widget con
Các widget con có thể truy cập vào Notifier bằng cách sử dụng phương thức of trong CounterProvider. Dữ liệu trong Notifier có thể được hiển thị và tương tác từ các widget con.
Để hiển thị dữ liệu từ Notifier, bạn có thể sử dụng ValueListenableBuilder hoặc AnimatedBuilder.
 */
// AnimatedBuilder lắng nghe thay đổi từ counter và cập nhật giao diện khi giá trị thay đổi.
class CounterDisplay2 extends StatelessWidget {
  const CounterDisplay2({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CounterProvider2.of(context),
      builder: (context, child) {
        return Text(
          'Count: ${CounterProvider2.of(context).count}',
          style: Theme.of(context).textTheme.labelLarge,
        );
      },
    );
  }
}

//  phương thức increment/decrement của CounterNotifier được gọi và dữ liệu được cập nhật.
class CounterButtons extends StatelessWidget {
  const CounterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            CounterProvider2.of(context).decrement();
          },
          child: const Text('Decrement'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            CounterProvider2.of(context).increment();
          },
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
/* Trong trường hợp của ChangeNotifier, cần gọi dispose() và notifyListeners() vì:

dispose():
ChangeNotifier yêu cầu dọn dẹp khi không còn được sử dụng nữa để tránh rò rỉ bộ nhớ (memory leaks). Nó quản lý danh sách các listener (những thành phần được thông báo khi có sự thay đổi), vì vậy khi widget không còn tồn tại, bạn phải gọi dispose() để giải phóng các listener này.

notifyListeners():
ChangeNotifier cần phương thức này để thông báo cho tất cả các listener rằng dữ liệu đã thay đổi và các widget liên quan cần được vẽ lại.
Trong khi đó, ValueNotifier<int> đã có sẵn cơ chế thông báo thay đổi tự động khi giá trị thay đổi. Nó là một phiên bản đặc biệt của ChangeNotifier, được tối ưu hóa cho các giá trị đơn lẻ và không cần bạn phải gọi notifyListeners() theo cách thủ công. ValueNotifier cũng quản lý tài nguyên dễ hơn, nên không cần dispose() trong nhiều trường hợp đơn giản.

Tóm lại:
ChangeNotifier yêu cầu dọn dẹp và thông báo thủ công cho các listener.
ValueNotifier có cơ chế tự động, đơn giản hơn trong quản lý giá trị. */