import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyShortcut extends StatelessWidget {
  const MyShortcut({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Shortcut Sample')),
        body: const Shortcut4(),
      ),
    );
  }
}

// Example 1
//If all you need are callbacks without the flexibility of Actions and Shortcuts, you can use the CallbackShortcuts widget:
///This is similar to but simpler than the Shortcuts widget as it doesn't require Intents and Actions widgets. Instead, it accepts a map of ShortcutActivators to VoidCallbacks.
///Unlike Shortcuts, this widget does not separate key bindings and their implementations. This separation allows Shortcuts to have key bindings that adapt to the focused context. For example, the desired action for a deletion intent may be to delete a character in a text input, or to delete a file in a file menu.
class Shortcut1 extends StatefulWidget {
  const Shortcut1({super.key});

  @override
  State<Shortcut1> createState() => _Shortcut1State();
}

int count = 0;

class _Shortcut1State extends State<Shortcut1> {
  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
//  required Map<SingleActivator, VoidCallback> bindings:
// is a Map<Key, Value> -->  Map<SingleActivator, void Function()>
// Khai báo map shortcut với SingleActivator - chỉ triển khai được với SingleActivator
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): () {
          setState(() => count = count + 1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowDown): () {
          setState(() => count = count - 1);
        },
      },
      //  required Widget child:
      child: Focus(
        // phải có Focus để nhận sự kiện
        autofocus: true,
        child: Column(
          children: <Widget>[
            const Text('Press the up arrow key to add to the counter'),
            const Text('Press the down arrow key to subtract from the counter'),
            Text('count: $count'),
          ],
        ),
      ),
    );
  }
}

// Example 2
/// Intent là một lớp trừu tượng được sử dụng để map tới một hành động cụ thể. Intent được sử dụng để kích hoạt hành động.
class IncrementIntent extends Intent {
  const IncrementIntent();
}

class DecrementIntent extends Intent {
  const DecrementIntent();
}

class Shortcut2 extends StatefulWidget {
  const Shortcut2({super.key});

  @override
  State<Shortcut2> createState() => _Shortcut2State();
}

class _Shortcut2State extends State<Shortcut2> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      //  required Map<ShortcutActivator, Intent> shortcuts:
      //  Map<ShortcutActivator, Intent> --> Map<SingleActivator, IncrementIntent>
      //Creates a const [Shortcuts] widget that owns the map of shortcuts and creates its own manager.
      shortcuts: <LogicalKeySet, Intent>{
        // 2 cách triển khai map shortcut: intent - khuyến khích dùng SingleActivator
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const IncrementIntent(),
        // const SingleActivator(LogicalKeyboardKey.arrowDown):
        //     const DecrementIntent()
      },
      //required Widget child: - con của Shortcuts
      child: Actions(
        // required Map<Type, Action<Intent>> actions:
        //  ánh xạ từ loại hành động (Type) đến hành động (Action) cụ thể.
        // <Type, Action<Intent>> --> IncrementIntent: CallbackAction<IncrementIntent>
        // A map of [Intent] keys to [Action] objects that defines which actions this widget knows about.
        actions: <Type, Action<Intent>>{
          // CallbackAction<T extends Intent>
          IncrementIntent: CallbackAction<IncrementIntent>(
            // required void Function(T intent) onInvoke:
            onInvoke: (IncrementIntent intent) => setState(
              () {
                count = count + 1;
              },
            ),
          ),
          DecrementIntent: CallbackAction<DecrementIntent>(
            onInvoke: (DecrementIntent intent) => setState(() {
              count = count - 1;
            }),
          ),
        },
        // required Widget child: - con của Actions
        child: Focus(
          // phải có Focus để nhận sự kiện
          autofocus: true,
          child: Column(
            children: <Widget>[
              const Text('Shortcuts Example 2'),
              const Text('Add to the counter by pressing the up arrow key'),
              const Text(
                  'Subtract from the counter by pressing the down arrow key'),
              Text('count: $count'),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 3
/// Model là một lớp được kế thừa từ ChangeNotifier. ChangeNotifier là một phần của Flutter được sử dụng để quản lý trạng thái và thông báo sự thay đổi trong trạng thái đó cho các thành phần giao diện người dùng.
class Model with ChangeNotifier {
  int count = 0;
  void incrementBy(int amount) {
    count += amount;
    notifyListeners();
  }

  void decrementBy(int amount) {
    count -= amount;
    notifyListeners();
  }
}

/// Intent là một lớp trừu tượng được sử dụng để map tới một hành động cụ thể. Intent được sử dụng để kích hoạt hành động.
class IncrementIntent1 extends Intent {
  const IncrementIntent1(this.amount);

  final int amount;
}

class DecrementIntent1 extends Intent {
  const DecrementIntent1(this.amount);

  final int amount;
}

/// Action là một lớp trừu tượng được sử dụng để thực thi một Intent cụ thể. Action được sử dụng để thực thi một Intent.
class IncrementAction extends Action<IncrementIntent1> {
  IncrementAction(this.model);
  final Model model;

  /// Thực thi một Intent cụ thể.
  //   void invoke(covariant T intent);
  @override
  // 'covariant' cho phép bạn sử dụng một kiểu con của IncrementIntent1 làm tham số cho hàm invoke, giúp linh hoạt hơn trong việc sử dụng các loại tham số.
  void invoke(covariant IncrementIntent1 intent) {
    model.incrementBy(intent.amount);
  }
}

class DecrementAction extends Action<DecrementIntent1> {
  DecrementAction(this.model);

  final Model model;

  @override

  /// Thực thi một Intent cụ thể.
  //   void invoke(covariant T intent);
  void invoke(covariant DecrementIntent1 intent) {
    model.decrementBy(intent.amount);
  }
}

class Shortcut3 extends StatefulWidget {
  const Shortcut3({super.key});

  @override
  State<Shortcut3> createState() => _Shortcut3State();
}

class _Shortcut3State extends State<Shortcut3> {
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        // có thể sử dụng LogicalKeySet hoặc SingleActivator, khuyến khích dùng SingleActivator
        SingleActivator(LogicalKeyboardKey.arrowUp):
            IncrementIntent1(2), // truyền tham số qua Intent
        SingleActivator(LogicalKeyboardKey.arrowDown): DecrementIntent1(2),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          IncrementIntent1: IncrementAction(model), // truyền tham số qua Action
          DecrementIntent1: DecrementAction(model),
        },
        child: Focus(
          // phải có Focus để nhận sự kiện
          autofocus: true,
          child: Column(
            children: <Widget>[
              const Text('Shortcuts Example 3'),
              const Text('Add to the counter by pressing the up arrow key'),
              const Text(
                  'Subtract from the counter by pressing the down arrow key'),
              // AnimatedBuilder là một widget được sử dụng để xây dựng các widget khác dựa trên các giá trị của một hoặc nhiều đối tượng Animation.
              // để cập nhật giao diện người dùng khi giá trị count thay đổi.
              AnimatedBuilder(
                animation: model,
                builder: (BuildContext context, Widget? child) {
                  return Text('count: ${model.count}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 4 - test LogicalKeySet and SingleActivator

class IncrementIntent4 extends Intent {
  const IncrementIntent4();
}

class Shortcut4 extends StatefulWidget {
  const Shortcut4({super.key});

  @override
  State<Shortcut4> createState() => _LogicalKeySetExampleState();
}

class _LogicalKeySetExampleState extends State<Shortcut4> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      // Khai báo ShortcutActivator - triển khai được cả LogicalKeySet và SingleActivator
      shortcuts: <ShortcutActivator, Intent>{
        // map shortcut với LogicalKeySet
        LogicalKeySet(LogicalKeyboardKey.keyC, LogicalKeyboardKey.controlLeft):
            const IncrementIntent4(),
        // map shortcut với SingleActivator
        const SingleActivator(LogicalKeyboardKey.keyJ, control: true):
            const IncrementIntent4(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          IncrementIntent4: CallbackAction<IncrementIntent4>(
            onInvoke: (IncrementIntent4 intent) => setState(() {
              count = count + 1;
            }),
          ),
        },
        child: Focus(
          // phải có Focus để nhận sự kiện
          autofocus: true,
          child: Column(
            children: <Widget>[
              const Text('Example 4 - test LogicalKeySet and SingleActivator'),
              const Text('Add to the counter by pressing Ctrl+C or Ctrl+J'),
              Text('count: $count'),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 5 - dispatch property
