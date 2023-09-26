import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyMenuAnchor extends StatelessWidget {
  const MyMenuAnchor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('MenuAnchor  Sample')),
        body: const MenuAnchor3(),
      ),
    );
  }
}

//

class MenuAnchor0 extends StatefulWidget {
  const MenuAnchor0({super.key});

  @override
  State<MenuAnchor0> createState() => _MenuAnchor0State();
}

enum EnumItem { item1, item2, item3 }

class _MenuAnchor0State extends State<MenuAnchor0> {
  EnumItem?
      selectedMenu; // phải đặt ngoài hàm build thì mới update value khi onPressed trên item

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MenuAnchor(
            // buider: định nghĩa widget để kích hoạt(click) vào show menu ra
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert_rounded),
                tooltip: 'Show menu',
              );
            },
            // menuChildren: A list of children containing the menu items
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  setState(() {
                    selectedMenu = EnumItem.item1;
                    debugPrint('$selectedMenu');
                  });
                },
                child: const Text('Item 1'),
              ),
              MenuItemButton(
                onPressed: () {
                  setState(() {
                    selectedMenu = EnumItem.item2;
                    debugPrint('$selectedMenu');
                  });
                },
                child: const Text('Item 2'),
              ),
              MenuItemButton(
                onPressed: () {
                  setState(() {
                    selectedMenu = EnumItem.item3;
                    debugPrint('$selectedMenu');
                  });
                },
                child: const Text('Item 3'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Mục đã chọn: ${selectedMenu?.name ?? "Chưa chọn"}', // nếu selectedMenu = null thì in "Chưa chọn"
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

//

class MenuAnchor1 extends StatefulWidget {
  const MenuAnchor1({super.key});

  @override
  State<MenuAnchor1> createState() => _MenuAnchor1State();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _MenuAnchor1State extends State<MenuAnchor1> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MenuAnchor(
        // buider: định nghĩa widget để kích hoạt(click) vào show menu ra
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_vert_rounded),
            tooltip: 'Show menu',
          );
        },
        // menuChildren: A list of children containing the menu items
        menuChildren: List<MenuItemButton>.generate(
          3,
          (int index) => MenuItemButton(
            onPressed: () =>
                setState(() => selectedMenu = SampleItem.values[index]),
            child: Text(selectedMenu?.name ??
                'Item $index'), // selectedMenu?.name là null, thì Text sẽ hiển thị 'Item $index', ngược lại nó sẽ hiển thị giá trị của selectedMenu.name
          ),
        ),
      ),
    );
  }
}

// kết hợp shortcut với menu
class MenuAnchor3 extends StatefulWidget {
  const MenuAnchor3({super.key});

  @override
  State<MenuAnchor3> createState() => _MenuAnchor3State();
}

class _MenuAnchor3State extends State<MenuAnchor3> {
  static const String kMessage = '"Talk less. Smile more." - A. Burr';
  @override
  Widget build(BuildContext context) {
    return const MyCascadingMenu(message: kMessage);
  }
}

// list menu entry và định nghĩa shortcut kèm theo
enum MenuEntry {
  about('About'),
  showMessage(
      'Show Message', SingleActivator(LogicalKeyboardKey.keyS, control: true)),
  hideMessage(
      'Hide Message', SingleActivator(LogicalKeyboardKey.keyS, control: true)),
  colorMenu('Color Menu'),
  colorRed('Red Background',
      SingleActivator(LogicalKeyboardKey.keyR, control: true)),
  colorGreen('Green Background',
      SingleActivator(LogicalKeyboardKey.keyG, control: true)),
  colorBlue('Blue Background',
      SingleActivator(LogicalKeyboardKey.keyB, control: true));

  const MenuEntry(this.label, [this.shortcut]);
  final String label;
  final MenuSerializableShortcut? shortcut;
}

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key, required this.message});

  final String message;

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  MenuEntry? _lastSelection; // lưu giá trị của item menu được chọn cuối cùng
  final FocusNode _buttonFocusNode =
      FocusNode(debugLabel: 'Menu Button'); // focus node của button
  ShortcutRegistryEntry? _shortcutsEntry; // đăng ký shortcut

  Color get backgroundColor =>
      _backgroundColor; // lấy giá trị màu nền ban đầu khi load form
  Color _backgroundColor = Colors.white;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage =>
      _showingMessage; // lấy giá trị của biến _showingMessage: true/false - cho phép show message hay không
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Dispose of any previously registered shortcuts, since they are about to
    // be replaced. - dispose các shortcut đã được đăng ký trước đó, vì chúng sẽ được thay thế
    _shortcutsEntry?.dispose();
    // Collect the shortcuts from the different menu selections so that they can
    // be registered to apply to the entire app. Menus don't register their
    // shortcuts, they only display the shortcut hint text. -
    //thu thập các shortcut từ các menu khác nhau để đăng ký áp dụng cho toàn bộ ứng dụng. Menu không đăng ký các shortcut của chúng, chúng chỉ hiển thị văn bản gợi ý phím tắt.
    final Map<ShortcutActivator, Intent> shortcuts =
        <ShortcutActivator, Intent>{
      for (final MenuEntry item in MenuEntry.values)
        if (item.shortcut != null)
          item.shortcut!: VoidCallbackIntent(() => _activate(item)), //
    };
    // Register the shortcuts with the ShortcutRegistry so that they are
    // available to the entire application.
    ///A entry returned by ShortcutRegistry.addAll that allows the caller to identify the shortcuts they registered with the ShortcutRegistry through the ShortcutRegistrar.
    ///When the entry is no longer needed, dispose should be called, and the entry should no longer be used.
    _shortcutsEntry = ShortcutRegistry.of(context).addAll(shortcuts);
  }

  @override
  // dispose các shortcut đã được đăng ký trước đó, vì chúng sẽ được thay thế
  void dispose() {
    _shortcutsEntry?.dispose();
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // MenuAnchor: A widget that displays a menu when a button is pressed.
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          // required - menuChildren: (of MenuAnchor) A list of children containing the menu items
          menuChildren: <Widget>[
            MenuItemButton(
              child: Text(MenuEntry.about.label),
              onPressed: () => _activate(MenuEntry.about),
            ),
            if (_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                shortcut: MenuEntry.hideMessage.shortcut,
                child: Text(MenuEntry.hideMessage.label),
              ),
            if (!_showingMessage)
              MenuItemButton(
                //
                onPressed: () => _activate(MenuEntry.showMessage),
                shortcut: MenuEntry.showMessage.shortcut,
                child: Text(MenuEntry.showMessage.label),
              ),
            // SubmenuButton: A button that displays a submenu when pressed.
            SubmenuButton(
              menuChildren: <Widget>[
                // required - menuChildren: (of SubmenuButton) A list of children containing the menu items
                MenuItemButton(
                  onPressed: () => _activate(
                      MenuEntry.colorRed), // hàm xử lý khi click vào item menu
                  shortcut:
                      MenuEntry.colorRed.shortcut, // shortcut của item menu
                  child: Text(MenuEntry.colorRed.label), // label của item menu
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorGreen),
                  shortcut: MenuEntry.colorGreen.shortcut,
                  child: Text(MenuEntry.colorGreen.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorBlue),
                  shortcut: MenuEntry.colorBlue.shortcut,
                  child: Text(MenuEntry.colorBlue.label),
                ),
              ],
              child: const Text(
                  'Background Color'), // required - child: The widget to display as the button. (child là con trục tiếp của SubmenuButton ở trên, ko nằm trong menuChildren)
            ),
          ],
          builder: //  - builder: A builder that creates the widget that will be used to activate the menu.
              (BuildContext context, MenuController controller, Widget? child) {
            return TextButton(
              focusNode: _buttonFocusNode,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: const Text(
                  'OPEN MENU'), // required - child: The widget as label of button.
            );
          },
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    showingMessage
                        ? widget.message
                        : '', // showingMessage = true thì hiển thị widget.message, ngược lại thì hiển thị ''
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(_lastSelection != null
                    ? 'Last Selected: ${_lastSelection!.label}'
                    : ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

// _activate: hàm xử lý khi click vào item menu
  void _activate(MenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case MenuEntry.about:
        showAboutDialog(
          // call function showAboutDialog
          context: context,
          applicationName: 'MenuBar Sample',
          applicationVersion: '1.0.0',
        );
      case MenuEntry.hideMessage:
      case MenuEntry.showMessage:
        showingMessage = !showingMessage;
      case MenuEntry.colorMenu:
        break;
      case MenuEntry.colorRed:
        backgroundColor = Colors.red;
      case MenuEntry.colorGreen:
        backgroundColor = Colors.green;
      case MenuEntry.colorBlue:
        backgroundColor = Colors.blue;
    }
  }
}
