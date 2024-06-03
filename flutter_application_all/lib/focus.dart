import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFocus extends StatelessWidget {
  const MyFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Focus Sample')),
        body: const Focus4(),
      ),
    );
  }
}

// Example 1 - FocusNode, không dùng widget Focus

class Focus1 extends StatelessWidget {
  const Focus1({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.headlineMedium!,
      child: const ColorfulButton(),
    );
  }
}

class ColorfulButton extends StatefulWidget {
  const ColorfulButton({super.key});

  @override
  State<ColorfulButton> createState() => _ColorfulButtonState();
}

class _ColorfulButtonState extends State<ColorfulButton> {
  late FocusNode _node; // khai báo focus node
  bool _focused = false; // khai báo biến kiểm tra trạng thái focus
  late FocusAttachment
      _nodeAttachment; // khai báo focus attachment - sử dụng để gắn _node với BuildContext.
  Color _color = Colors.white;

  @override
  // khoi tao gia tri ban dau, run truoc build function
  void initState() {
    //
    super.initState();
    _node = FocusNode(debugLabel: 'Button'); // khởi tạo focus node
    _node.addListener(_handleFocusChange); // add listener cho focus node
    _nodeAttachment = _node.attach(context,
        onKey: _handleKeyPress); // attach focus node với context
  }

// khi focus thay đổi thì cập nhật trạng thái của _focused
  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      // kiểm tra trạng thái focus của node
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

//  Hàm này xử lý sự kiện phím. Nếu người dùng nhấn các phím R, G, hoặc B, màu sắc của nút sẽ thay đổi tương ứng và sự kiện phím được xử lý và trả về KeyEventResult.handled.
  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    // RawKeyEvent: sự kiện phím
    if (event is RawKeyDownEvent) {
      // RawKeyDownEvent: sự kiện khi nhấn phím
      debugPrint(
          'Focus node ${node.debugLabel} got key event: ${event.logicalKey}'); // ${event.logicalKey} - LogicalKeyboardKey#1b3a4(keyId: "0x00000064", keyLabel: "D", debugName: "Key D")
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        debugPrint('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return KeyEventResult
            .handled; // KeyEventResult.handled: sự kiện phím đã được xử lý
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        debugPrint('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        debugPrint('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult
        .ignored; // KeyEventResult.ignored: sự kiện phím không được xử lý
  }

  @override
  // khi widget bị xóa thì dispose focus node
  void dispose() {
    _node.removeListener(_handleFocusChange); // remove listener
    // The attachment will automatically be detached in dispose().
    _node.dispose(); // dispose focus node
    super.dispose(); // dispose widget
  }

  @override
  Widget build(BuildContext context) {
    // _nodeAttachment. reparent() được gọi để đảm bảo rằng _node được gắn lại vào ngữ cảnh (context) hiện tại. Điều này quan trọng để quản lý tập trung và sự kiện phím.
    _nodeAttachment.reparent();
    return GestureDetector(
      // GestureDetector, cho phép xử lý các sự kiện như nhấn (tap) trên nút.
      onTap: () {
        // khi nhấn vào nút
        if (_focused) {
          // switch focus true/false
          _node.unfocus(); // unfocus node
        } else {
          _node.requestFocus(); // focus node
        }
      },
      child: Center(
        child: Container(
          width: 400,
          height: 100,
          color: _focused ? _color : Colors.white,
          alignment: Alignment.center,
          child:
              Text(_focused ? "I'm in color! Press R,G,B!" : 'Press to focus'),
        ),
      ),
    );
  }
}

// Example 2 - Focus, dùng widget FocusScope và Focus

class Focus2 extends StatefulWidget {
  const Focus2({super.key});

  @override
  State<Focus2> createState() => _Focus2State();
}

class _Focus2State extends State<Focus2> {
  Color _color = Colors.white;

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      debugPrint(
          'Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        debugPrint('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        debugPrint('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        debugPrint('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    // FocusScope: FocusScope là một widget cha cho Focus. Nó sẽ tạo ra một ngữ cảnh tập trung mới và sử dụng nó để tập trung vào FocusNode con đầu tiên của nó.
    // Widget gốc của ứng dụng là FocusScope, và nó định nghĩa phạm vi tập trung (focus scope) cho widget con bên trong. autofocus: true cho phép widget này tự động tập trung khi ứng dụng được khởi chạy.
    return FocusScope(
      debugLabel: 'Scope', // debugLabel: nhãn để gỡ lỗi
      autofocus: true,
      child: DefaultTextStyle(
        style: textTheme.headlineMedium!,
        child: Focus(
          //
          onKey:
              _handleKeyPress, // onKey: sự kiện phím - Đây là callback được gọi khi người dùng nhấn các phím trên bàn phím
          debugLabel: 'Button',
          child: Builder(
            // Widget này sử dụng Builder để tạo ra một BuildContext riêng cho widget con bên trong nó. Điều này là cần thiết vì FocusScope không phải là một widget con của MaterialApp, vì vậy nó không có một BuildContext để sử dụng.
            builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(
                  context); // Focus.of(context) - trả về focus node của widget cha gần nhất
              final bool hasFocus =
                  focusNode.hasFocus; // lấy giá trị hasFocus của focus node
              return GestureDetector(
                // GestureDetector, cho phép xử lý các sự kiện như nhấn (tap) trên nút.
                onTap: () {
                  // click vào: switch focus true/false
                  if (hasFocus) {
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 100,
                    alignment: Alignment.center,
                    color: hasFocus ? _color : Colors.white,
                    child: Text(hasFocus
                        ? "I'm in color! Press R,G,B! Click to unfocus."
                        : 'Click to focus'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Example 3 - Chỉ dùng widget Focus

class Focus3 extends StatelessWidget {
  const Focus3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => FocusableText(
        'Item $index',
        autofocus: index == 10,
      ),
      itemCount: 50,
    );
  }
}

class FocusableText extends StatelessWidget {
  const FocusableText(
    this.data, {
    super.key,
    required this.autofocus,
  });

  /// The string to display as the text for this widget.
  final String data;

  /// Whether or not to focus this widget initially if nothing else is focused.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus, // Must not be null. Defaults to false.
      child: Builder(builder: (BuildContext context) {
        // The contents of this Builder are being made focusable. It is inside
        // of a Builder because the builder provides the correct context
        // variable for Focus.of() to be able to find the Focus widget that is
        // the Builder's parent. Without the builder, the context variable used
        // would be the one given the FocusableText build function, and that
        // would start looking for a Focus widget ancestor of the FocusableText
        // instead of finding the one inside of its build function.
        return Container(
          padding: const EdgeInsets.all(8.0),
          // Change the color based on whether or not this Container has focus.
          // hasPrimaryFocus là thuộc tính của đối tượng Focus, được sử dụng để kiểm tra xem một phần tử (widget) có được focus hay không.
          color: Focus.of(context).hasPrimaryFocus
              ? const Color.fromARGB(31, 245, 98, 6)
              : null,
          child: Text(data),
        );
      }),
    );
  }
}
// Example 4 -  dùng List<FocusNode> để quản lý focus node

class Focus4 extends StatefulWidget {
  const Focus4({super.key});

  @override
  State<Focus4> createState() => _Focus4State();
}

class _Focus4State extends State<Focus4> {
  int focusedChild = 0; // index của child đang được focus
  List<Widget> children = <Widget>[]; // list các child
  List<FocusNode> childFocusNodes = <FocusNode>[]; // list các focus node
  @override
  void initState() {
    super.initState();
    // Add the first child.
    _addChild();
  }

  void _addChild() {
    // Calling requestFocus here creates a deferred request for focus, since the
    // node is not yet part of the focus tree.
    childFocusNodes.add(FocusNode(
        debugLabel:
            'Child ${children.length}')); // add focus node mới vào list. lần đầu tiên = 0 do list widget rỗng

// Set vị trí focus trong childFocusNodes
    // ignore: prefer_is_empty
    if (children.length > 1) {
      // Calling requestFocus here creates a deferred request for focus, since
      // the node is not yet part of the focus tree.
      childFocusNodes
          .elementAt(1)
          .requestFocus(); // phải set focusNode: childFocusNodes.last (ở dưới) thì mới có tác dụng
    }
    children.add(Padding(
      // add widget vào list
      padding: const EdgeInsets.all(2.0),
      child: ActionChip(
        autofocus: true,
        focusNode: childFocusNodes
            .last, // để set vị trí note focus được thì phải set focusNode: childFocusNodes.last (childFocusNodes.first thì ko tác dụng)
        label: Text('CHILD ${children.length}'),
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: children,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            focusedChild = children.length;
            debugPrint(childFocusNodes.last.toString());
            debugPrint('Adding child $focusedChild');
            _addChild();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
