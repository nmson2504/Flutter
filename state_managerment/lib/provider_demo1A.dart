import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// đặt MultiProvider trong  Widget build, lúc này MultiProvider có child là MaterialApp
class MyAppProvider1A extends StatelessWidget {
  const MyAppProvider1A({super.key});

  @override
  Widget build(BuildContext context) {
    return const Example03();
  }
}

// Sử dụng context.watch() và context.read()
/* 
context.watch() và context.read() đều được sử dụng để truy cập dữ liệu từ Provider trong Flutter, nhưng chúng có mục đích khác nhau:
1.	context.watch(): Lắng nghe sự thay đổi trạng thái và tự động xây dựng lại widget khi trạng thái thay đổi. Dùng khi bạn muốn UI tự động cập nhật.
var count = context.watch<CounterModel>().count;
2.	context.read(): Truy cập trạng thái nhưng không lắng nghe thay đổi. Dùng khi bạn chỉ cần lấy giá trị một lần hoặc thực hiện hành động mà không cần UI cập nhật.
context.read<CounterModel>().increment();

 */

// Example 1
class Example01 extends StatelessWidget {
  const Example01({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: const MyApp01(),
    );
  }
}

class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Gọi hàm này để thông báo cho UI về sự thay đổi
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class MyApp01 extends StatelessWidget {
  const MyApp01({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // lắng nghe các thay đổi của theme. Mỗi khi theme thay đổi, widget này sẽ được rebuild.
      theme: context.watch<ThemeModel>().isDark ? ThemeData.dark() : ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeModel>().toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // context.watch<CounterModel>() theo dõi giá trị hiện tại của counter. Widget này sẽ được rebuild mỗi khi giá trị counter thay đổi.
              'Count: ${context.watch<CounterModel>().count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<CounterModel>().increment(),
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 2
class Example02 extends StatelessWidget {
  const Example02({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel02()),
        ChangeNotifierProvider(create: (context) => LanguageModel()),
      ],
      child: const MyApp02(),
    );
  }
}

class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});
}

class TaskModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  void toggleTask(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  int get completedTaskCount => _tasks.where((task) => task.isCompleted).length;
}

class ThemeModel02 extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class LanguageModel extends ChangeNotifier {
  bool _isEnglish = true;
  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }

  String get appTitle => _isEnglish ? 'Task Manager' : 'Quản lý công việc';
  String get addTaskHint => _isEnglish ? 'Add a new task' : 'Thêm công việc mới';
  String get addButton => _isEnglish ? 'Add' : 'Thêm';
  String get completedTasks => _isEnglish ? 'Completed Tasks' : 'Công việc đã hoàn thành';
}

class MyApp02 extends StatelessWidget {
  const MyApp02({super.key});

  @override
  Widget build(BuildContext context) {
    //  watch() để lắng nghe các thay đổi trong cả ThemeModel và LanguageModel. Điều này đảm bảo rằng toàn bộ ứng dụng sẽ được rebuild khi chủ đề hoặc ngôn ngữ thay đổi.
    final themeModel = context.watch<ThemeModel02>();
    final languageModel = context.watch<LanguageModel>();

    return MaterialApp(
      theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
      home: const HomePage02(),
      title: languageModel.appTitle,
    );
  }
}

class HomePage02 extends StatelessWidget {
  const HomePage02({super.key});

  @override
  Widget build(BuildContext context) {
    // lắng nghe các thay đổi trong TaskModel (để cập nhật danh sách công việc) và LanguageModel
    final taskModel = context.watch<TaskModel>();
    final languageModel = context.watch<LanguageModel>();
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(languageModel.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeModel02>().toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LanguageModel>().toggleLanguage(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: languageModel.addTaskHint,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      taskModel.addTask(_controller.text);
                      _controller.clear(); // xoá nội dung TextField
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskModel.tasks.length,
              itemBuilder: (context, index) {
                // Mặc dù không trực tiếp sử dụng watch() ở đây, nhưng vì chúng ta đã watch TaskModel ở cấp cao hơn, ListView sẽ được rebuild mỗi khi danh sách công việc thay đổi.
                final task = taskModel.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => taskModel.toggleTask(task.id),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              // Cả hai giá trị này đều được lấy từ các model đã được watch, nên sẽ tự động cập nhật khi có thay đổi.
              '${languageModel.completedTasks}: ${taskModel.completedTaskCount}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// Example 3
class Example03 extends StatelessWidget {
  const Example03({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ProductListModel()),
      ],
      child: const MyApp03(),
    );
  }
}

// Model cho sản phẩm
class Product {
  final String name;
  final double price;
  Product(this.name, this.price);
}

// ChangeNotifier cho giỏ hàng
class CartModel extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => _items;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

// syntax: collection.fold(initialValue, (accumulator, element) => ...)
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}

// ChangeNotifier cho quản lý người dùng
class UserModel extends ChangeNotifier {
  String? _username;
  String? get username => _username;

  void login(String username) {
    _username = username;
    notifyListeners();
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}

// ChangeNotifier cho danh sách sản phẩm
class ProductListModel extends ChangeNotifier {
  final List<Product> _products = [
    Product("Áo", 20),
    Product("Quần", 30),
    Product("Giày", 50),
  ];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}

class MyApp03 extends StatelessWidget {
  const MyApp03({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage03(),
    );
  }
}

class HomePage03 extends StatelessWidget {
  const HomePage03({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenHeight = MediaQuery.of(context).size.height;
    // Tính toán chiều cao cho SizedBox (ví dụ: 5% chiều cao màn hình)
    final spacerHeight = screenHeight * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng mua sắm'),
        actions: [
          Consumer<UserModel>(
            builder: (context, userModel, child) {
              if (userModel.username == null) {
                return TextButton(
                  onPressed: () => userModel.login("NguyễnVănA"),
                  child: const Text('Đăng nhập', style: TextStyle(color: Colors.white)),
                );
              } else {
                return TextButton(
                  onPressed: () => userModel.logout(),
                  child: Text('Đăng xuất (${userModel.username})', style: const TextStyle(color: Colors.white)),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductListModel>(
              builder: (context, productListModel, child) {
                return ListView.builder(
                  itemCount: productListModel.products.length,
                  itemBuilder: (context, index) {
                    final product = productListModel.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          context.read<CartModel>().addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                                duration: const Duration(milliseconds: 500)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return Text(
                  'Tổng giá trị giỏ hàng: \$${cartModel.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          SizedBox(height: spacerHeight), // Khoảng trống tính theo tỷ lệ màn hình
        ],
      ),
    );
  }
}
