import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// đặt MultiProvider trong  Widget build, lúc này MultiProvider có child là MaterialApp
class MyAppProvider1B extends StatelessWidget {
  const MyAppProvider1B({super.key});

  @override
  Widget build(BuildContext context) {
    return const Example01C1();
  }
}

// Các cách khai báo model khác nhau
/* 
1- Mô hình không thay đổi (Immutable Model)
Dữ liệu trong mô hình không bị thay đổi trong suốt vòng đời của ứng dụng. Điều này thường được sử dụng khi bạn chỉ cần đọc dữ liệu một lần và không cần quan tâm đến việc dữ liệu có thể thay đổi.
Khai báo Provider đơn giản vì không có logic thay đổi trạng thái cần quản lý.
 Syntax: Provider(create: (context) => CatalogModel()),
Định nghĩa model ko extends ChangeNotifier, ko gọi method notifyListeners()
2. Mô hình có thay đổi (Mutable Model - cho phép update data lên UI)
Dữ liệu trong mô hình có thể thay đổi và cần được lắng nghe để cập nhật giao diện người dùng (UI).
Khai báo Provider với keyword ChangeNotifierProvider:
 ChangeNotifierProvider(create: (context) => CounterModel()),
Định nghĩa model phải extends ChangeNotifier, có gọi method notifyListeners()
3. Sử dụng ProxyProvider khi mô hình phụ thuộc lẫn nhau
Khi một mô hình phụ thuộc vào một mô hình khác, như trong trường hợp CartModel phụ thuộc vào CatalogModel, bạn sẽ sử dụng ProxyProvider. Đây là một loại Provider đặc biệt cho phép bạn cập nhật một mô hình dựa trên thay đổi của một mô hình khác
Khai báo Provider với keyword ChangeNotifierProxyProvider:
ChangeNotifierProxyProvider<CatalogModel, CartModel>(
  create: (context) => CartModel(),
  update: (context, catalog, cart) {
    if (cart == null) throw ArgumentError.notNull('cart');
    cart.catalog = catalog; // Cập nhật catalog mới vào CartModel
    return cart;
  },
  // CartModel cần tham chiếu đến CatalogModel. Bất cứ khi nào CatalogModel thay đổi, CartModel cũng sẽ được cập nhật.
),
 */

// Example 1
// Vẫn có thể khai khai báo Provider với mutable model nhưng UI sẽ ko cập nhật khi thay đổi giá trị trong model
class Example01 extends StatelessWidget {
  const Example01({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImmutableModel>(
          create: (_) => ImmutableModel('John Doe'),
        ),
        // Vẫn có thể khai khai báo Provider với mutable model nhưng UI sẽ ko cập nhật khi thay đổi giá trị trong model
        // Cụ thể khi click button 'Update Mutable Model Name' tuy giá trị mới đã update trong model nhưng ko được cập nhật lên UI
        Provider<MutableModel>(
          create: (_) => MutableModel('Cu Minh'),
        ),
        ChangeNotifierProvider<ChangeNotifierModel>(
          create: (_) => ChangeNotifierModel('Initial Name'),
        ),
      ],
      child: const MaterialApp(
        title: 'Provider Demo',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final immutableModel = Provider.of<ImmutableModel>(context);
    final mutableModel = Provider.of<MutableModel>(context);
    final changeNotifierModel = Provider.of<ChangeNotifierModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Immutable Model: ${immutableModel.name}'),
            const SizedBox(height: 20),
            Text('Mutable Model: ${mutableModel.name}'),
            ElevatedButton(
              onPressed: () {
                // Gọi phương thức updateName
                mutableModel.updateName('Updated Name');
              },
              child: const Text('Update Mutable Model Name'),
            ),
            const SizedBox(height: 20),
            Text('ChangeNotifier Model: ${changeNotifierModel.name}'),
            ElevatedButton(
              onPressed: () {
                // Gọi phương thức updateName
                changeNotifierModel.updateName('Changed Name');
              },
              child: const Text('Update ChangeNotifier Model Name'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImmutableModel {
  final String name;

  ImmutableModel(this.name);
}

class MutableModel {
  String name;

  MutableModel(this.name);

  void updateName(String newName) {
    name = newName; // Không thông báo thay đổi
  }
}

class ChangeNotifierModel with ChangeNotifier {
  String _name;

  ChangeNotifierModel(this._name);

  String get name => _name;

  void updateName(String newName) {
    _name = newName;
    notifyListeners(); // Thông báo thay đổi
  }
}

// Example - ChangeNotifierProvider & ChangeNotifierProxyProvider.

// Mô hình Counter
class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Mô hình Message
class MessageModel extends ChangeNotifier {
  String _message = 'Count is: 0';

  String get message => _message;

  void updateMessage(int count) {
    _message = 'Count is: $count';
    notifyListeners();
  }
}
// Example - ChangeNotifierProvider & ChangeNotifierProxyProvider.

class Example01a extends StatelessWidget {
  const Example01a({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cung cấp một instance của CounterModel, cho phép các widget lắng nghe sự thay đổi trong giá trị của count.
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProxyProvider<CounterModel, MessageModel>(
          create: (_) => MessageModel(),
          //   update: (context, previousModel, newModel)
          // Tham số counter là instance hiện tại của CounterModel, cho phép bạn truy cập giá trị count từ model này.
          update: (context, counter, messageModel) {
            messageModel?.updateMessage(counter.count);
            return messageModel!;
          },
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('ChangeNotifierProvider & ChangeNotifierProxyProvider.')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hiển thị giá trị đếm
              Consumer<CounterModel>(
                builder: (context, counter, child) {
                  return Text(
                    'CounterModel: ${counter.count}',
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Hiển thị thông điệp
              Consumer<MessageModel>(
                builder: (context, messageModel, child) {
                  return Text(
                    messageModel.message,
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Nút tăng giá trị
              ElevatedButton(
                onPressed: () {
                  Provider.of<CounterModel>(context, listen: false).increment();
                },
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Về ProxyProvider
/* 
Khi một mô hình phụ thuộc vào một mô hình khác, như trong trường hợp AnotherModel phụ thuộc vào MyModel, bạn sẽ sử dụng ProxyProvider. Đây là một loại Provider đặc biệt cho phép bạn cập nhật một mô hình dựa trên thay đổi của một mô hình khác
 */
// Example01B - ProxyProvider ko dùng ChangeNotifier
// phải dùng StatefulWidget để setState()
class Example01B extends StatelessWidget {
  const Example01B({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyModelX>(create: (context) => MyModelX()),
        ProxyProvider<MyModelX, AnotherModelX>(
          update: (context, myModel, anotherModel) => AnotherModelX(myModel),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('My App ProxyProvider ko dùng ChangeNotifier')),
          body: const ExampleBody(),
        ),
      ),
    );
  }
}

class ExampleBody extends StatefulWidget {
  const ExampleBody({super.key});

  @override
  _ExampleBodyState createState() => _ExampleBodyState();
}

class _ExampleBodyState extends State<ExampleBody> {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModelX>(context);
    final anotherModel = Provider.of<AnotherModelX>(context);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green[200],
                child: ElevatedButton(
                  child: const Text('Do something'),
                  onPressed: () {
                    setState(() {
                      myModel.doSomething('Goodbye');
                    });
                  },
                )),
            Container(
              padding: const EdgeInsets.all(35),
              color: Colors.blue[200],
              child: Text(myModel.someValue),
            ),
            Container(
              padding: const EdgeInsets.all(35),
              color: const Color.fromARGB(255, 234, 127, 246),
              child: Text('${myModel.count}'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                color: Colors.red[200],
                child: ElevatedButton(
                  child: const Text('Do something else'),
                  onPressed: () {
                    setState(() {
                      anotherModel.doSomethingElse();
                    });
                  },
                )),
            Container(
              padding: const EdgeInsets.all(35),
              color: Colors.blue[100],
              child: Text('${anotherModel.count}'),
            ),
          ],
        ),
      ],
    );
  }
}

class MyModelX {
  int count = 0; // update UI khi click trên cả 2 button

  String someValue = 'Hello';
  void doSomething(String value) {
    count++;
    someValue = value;
    print(someValue);
  }
}

class AnotherModelX {
  int count = 0;

  MyModelX _myModel;
  AnotherModelX(this._myModel);

  void doSomethingElse() {
    count++;
    _myModel.doSomething('See you later');
    print('doing something else');
  }
}

// Example01C - ProxyProvider
class Example01C extends StatelessWidget {
  const Example01C({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ProxyProvider<MyModel, AnotherModel>(
          update: (context, myModel, anotherModel) => AnotherModel(myModel),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('My App ProxyProvider')),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.green[200],
                      child: Consumer<MyModel>(
                        //          <--- MyModel Consumer
                        builder: (context, myModel, child) {
                          return ElevatedButton(
                            child: const Text('Do something'),
                            onPressed: () {
                              myModel.doSomething('Goodbye');
                            },
                          );
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[200],
                    child: Consumer<MyModel>(
                      //            <--- MyModel Consumer
                      builder: (context, myModel, child) {
                        return Text(myModel.someValue);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: const Color.fromARGB(255, 234, 127, 246),
                    child: Consumer<MyModel>(
                      //            <--- MyModel Consumer
                      builder: (context, myModel, child) {
                        return Text('${myModel.count}');
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.red[200],
                      child: Consumer<AnotherModel>(
                        //          <--- AnotherModel Consumer
                        builder: (context, anotherModel, child) {
                          return ElevatedButton(
                            child: const Text('Do something else'),
                            onPressed: () {
                              anotherModel.doSomethingElse();
                            },
                          );
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[100],
                    child: Consumer<AnotherModel>(
                      //            <--- MyModel Consumer
                      builder: (context, anotherModel, child) {
                        return Text('${anotherModel.count}');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  int count = 0; // update UI khi click trên cả 2 button

  String someValue = 'Hello';
  void doSomething(String value) {
    count++;
    someValue = value;
    print(someValue);
    notifyListeners();
  }
}

class MyModel0 {
  int count = 0; // update UI khi click trên cả 2 button

  String someValue = 'Hello';
  void doSomething(String value) {
    count++;
    someValue = value;
    print(someValue);
  }
}

class AnotherModel {
  int count = 0; // ko update UI

  MyModel _myModel;
  AnotherModel(this._myModel);
  void doSomethingElse() {
    count++;
    _myModel.doSomething('See you later');
    print('doing something else');
  }
}

// Example01D - ChangeNotifierProxyProvider
// , tất cả các tham số của ChangeNotifierProxyProvider phải là các lớp kế thừa từ ChangeNotifier.(các model truyền vào phải là ChangeNotifier)
class Example01D extends StatelessWidget {
  const Example01D({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
        ChangeNotifierProxyProvider<MyModel, AnotherModelCF>(
          create: (context) => AnotherModelCF(context.read<MyModel>()), // Tạo một instance của AnotherModelCF
          update: (context, myModel, anotherModel) {
            // Cập nhật AnotherModel khi MyModel thay đổ
            if (anotherModel == null) {
              return AnotherModelCF(myModel); // Trả về instance mới nếu anotherModel là null
            } else {
              anotherModel.updateMyModel(myModel); // Cập nhật lại MyModel cho AnotherModel
              return anotherModel;
            }
          },
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('My App ChangeNotifierProxyProvider')),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[200],
                    child: Consumer<MyModel>(
                      builder: (context, myModel, child) {
                        return ElevatedButton(
                          child: const Text('Do something'),
                          onPressed: () {
                            myModel.doSomething('Goodbye');
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[200],
                    child: Consumer<MyModel>(
                      builder: (context, myModel, child) {
                        return Text(myModel.someValue);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: const Color.fromARGB(255, 234, 127, 246),
                    child: Consumer<MyModel>(
                      builder: (context, myModel, child) {
                        return Text('${myModel.count}');
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.red[200],
                    child: Consumer<AnotherModelCF>(
                      builder: (context, anotherModel, child) {
                        return ElevatedButton(
                          child: const Text('Do something else'),
                          onPressed: () {
                            anotherModel.doSomethingElse();
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[100],
                    child: Consumer<AnotherModelCF>(
                      builder: (context, anotherModel, child) {
                        return Text('${anotherModel.count}');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnotherModelCF with ChangeNotifier {
  // Kế thừa ChangeNotifier
  int count = 0; // sẽ update UI

  MyModel _myModel;

  AnotherModelCF(this._myModel);

  void updateMyModel(MyModel myModel) {
    _myModel = myModel; // Cập nhật MyModel
  }

  void doSomethingElse() {
    count++;
    _myModel.doSomething('See you later');
    print('doing something else');
    notifyListeners(); // Phát tín hiệu để cập nhật UI
  }
}
// Example01C1 - ChangeNotifierProxyProvider
// , tất cả các tham số của ChangeNotifierProxyProvider phải là các lớp kế thừa từ ChangeNotifier.(các model truyền vào phải là ChangeNotifier)

class MyModelK extends ChangeNotifier {
  String _data = 'Initial Data';

  String get data => _data;
  // Danh sách chuỗi có sẵn
  final List<String> randomStrings = ['Flutter', 'Dart', 'Provider', 'ChangeNotifier', 'ProxyProvider'];

  // Hàm cập nhật giá trị với chuỗi ngẫu nhiên từ danh sách
  void updateData() {
    Random random = Random();
    _data = randomStrings[random.nextInt(randomStrings.length)];
    notifyListeners(); // Cập nhật UI khi giá trị thay đổi
  }
}

class MyNotifier extends ChangeNotifier {
  String _value = 'Notifier Data';

  String get value => _value;

  void updateValue(String newValue) {
    _value = newValue;
    notifyListeners(); // Cập nhật UI khi có sự thay đổi
  }
}

class Example01C1 extends StatelessWidget {
  const Example01C1({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModelK>(create: (_) => MyModelK()), // MyModel là ChangeNotifier
        ChangeNotifierProxyProvider<MyModelK, MyNotifier>(
          create: (context) => MyNotifier(),
          update: (context, myModel, myNotifier) {
            myNotifier?.updateValue(myModel.data); // Cập nhật giá trị dựa trên MyModel
            return myNotifier!;
          },
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('ChangeNotifierProxyProvider Example')),
          body: Center(
            child: Consumer<MyNotifier>(
              builder: (context, myNotifier, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Notifier Value: ${myNotifier.value}'),
                    ElevatedButton(
                      onPressed: () {
                        // Cập nhật giá trị trong MyModel
                        Provider.of<MyModelK>(context, listen: false)
                            .updateData(); // Gọi updateData để cập nhật và notifyListeners
                      },
                      child: const Text('Update Model Data'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ProxyProvider và ProxyProvider2
/* 
ProxyProvider và ProxyProvider2 là hai thành phần trong thư viện Provider của Flutter, cho phép bạn tạo ra một model mới dựa trên một hoặc nhiều model khác. Dưới đây là sự so sánh giữa hai loại này:

1. ProxyProvider
Mô tả: ProxyProvider cho phép bạn tạo ra một model mới dựa trên một model khác.
Cú pháp:
ProxyProvider<PreviousModel, NewModel>(
  update: (context, previousModel, newModel) {
    // Cập nhật NewModel dựa trên PreviousModel
    return newModel;
  },
)
Số lượng model phụ thuộc: Chỉ có một model phụ thuộc, tức là PreviousModel.
Sử dụng: Khi bạn chỉ cần một model duy nhất để tạo ra model mới.
2. ProxyProvider2
Mô tả: ProxyProvider2 mở rộng từ ProxyProvider, cho phép bạn tạo ra một model mới dựa trên hai model khác.
Cú pháp:
ProxyProvider2<PreviousModel1, PreviousModel2, NewModel>(
  update: (context, previousModel1, previousModel2, newModel) {
    // Cập nhật NewModel dựa trên PreviousModel1 và PreviousModel2
    return newModel;
  },
)
Số lượng model phụ thuộc: Có hai model phụ thuộc, tức là PreviousModel1 và PreviousModel2.
Sử dụng: Khi bạn cần kết hợp dữ liệu từ hai model để tạo ra model mới.
 */

// so sánh ProxyProvider và ChangeNotifierProxyProvider

// Model class

class CounterModel1 extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class StringModel extends ChangeNotifier {
  String _text = '';

  String get text => _text;

  void updateText(String newText) {
    _text = newText;
    notifyListeners();
  }
}

class Example01E extends StatelessWidget {
  const Example01E({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel1()),
        ProxyProvider<CounterModel1, String>(
          update: (_, counter, __) => 'ProxyProvider: Count: ${counter.count}', // Cập nhật một lần
        ),
        ChangeNotifierProxyProvider<CounterModel1, StringModel>(
          create: (_) => StringModel(),
          update: (_, counter, stringModel) {
            stringModel?.updateText('ChangeNotifierProxyProvider: Count is ${counter.count}'); // Cập nhật khi thay đổi
            return stringModel!;
          },
        ),
      ],
      child: const MyApp1(),
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ProxyProvider vs ChangeNotifierProxyProvider'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Hiển thị dữ liệu từ ProxyProvider (Chỉ cập nhật một lần)
              Consumer<String>(
                builder: (context, value, child) {
                  return Text(
                    value,
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Hiển thị dữ liệu từ ChangeNotifierProxyProvider (Cập nhật khi count thay đổi)
              Consumer<StringModel>(
                builder: (context, stringModel, child) {
                  return Text(
                    stringModel.text,
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Nút để tăng giá trị count trong CounterModel
              Consumer<CounterModel1>(
                builder: (context, counter, child) {
                  return ElevatedButton(
                    onPressed: () {
                      counter.increment(); // Tăng giá trị count và thông báo thay đổi
                    },
                    child: const Text('Increment Count'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 2
// ProxyProvider2
class Example02 extends StatelessWidget {
  const Example02({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ImmutableModel1>(
          create: (_) => ImmutableModel1("John", 30),
        ),
        ChangeNotifierProvider<MutableModel1>(
          create: (_) => MutableModel1("Doe", 25),
        ),
        ProxyProvider2<ImmutableModel1, MutableModel1, ProxyModel>(
          update: (_, immutableModel, mutableModel, __) => ProxyModel(
              immutableModel, mutableModel), // 2 tham số _ và __ truyền tham số ma cho BuildContext và ProxyModel
        ),
      ],
      child: const MaterialApp(
        title: 'Provider Demo',
        home: HomeScreen1(),
      ),
    );
  }
}

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final mutableModel = Provider.of<MutableModel1>(context);
    final proxyModel = Provider.of<ProxyModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Provider Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Mutable Model:'),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => mutableModel.updateName(value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) => mutableModel.updateAge(int.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 20),
            const Text('Proxy Model Info:'),
            Text(proxyModel.combinedInfo),
          ],
        ),
      ),
    );
  }
}

// Immutable Model
class ImmutableModel1 {
  final String name;
  final int age;

  ImmutableModel1(this.name, this.age);
}

// Mutable Model
class MutableModel1 with ChangeNotifier {
  String _name;
  int _age;

  MutableModel1(this._name, this._age);

  String get name => _name;
  int get age => _age;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
}

// ProxyModel
class ProxyModel {
  final ImmutableModel1 immutableModel;
  final MutableModel1 mutableModel;

  ProxyModel(this.immutableModel, this.mutableModel);

  String get combinedInfo =>
      'Name: ${mutableModel.name}, Age: ${mutableModel.age} (Immutable: ${immutableModel.name}, ${immutableModel.age})';
}
