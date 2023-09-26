import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyMenuBar000 extends StatelessWidget {
  const MyMenuBar000({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('MenuBar  Sample')),
        body: const MenuBar1(),
      ),
    );
  }
}

/// Flutter code sample for [MenuBar].

/// A class for consolidating the definition of menu entries.
///
/// This sort of class is not required, but illustrates one way that defining
/// menus could be done.
class MenuEntry {
  const MenuEntry(
      {required this.label, this.shortcut, this.onPressed, this.menuChildren})
      : assert(menuChildren == null || onPressed == null,
            'onPressed is ignored if menuChildren are provided');
  final String label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    // buildSelection(MenuEntry selection) builds a widget (SubmenuButton or MenuItemButton) from a selection (MenuEntry).
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          child: Text(selection.label),
        );
      }
      return MenuItemButton(
        shortcut: selection.shortcut,
        onPressed: selection.onPressed,
        child: Text(selection.label),
      );
    }

    return selections
        .map<Widget>(buildSelection)
        .toList(); //  ánh xạ (map) danh sách selections của các MenuEntry thành một danh sách các widget (List<Widget>).
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(MenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] =
              VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}

class MyMenuBar extends StatefulWidget {
  const MyMenuBar({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<MyMenuBar> createState() => _MyMenuBarState();
}

class _MyMenuBarState extends State<MyMenuBar> {
  ShortcutRegistryEntry? _shortcutsEntry;
  String? _lastSelection;

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showMessage;
  bool _showMessage = false;
  set showingMessage(bool value) {
    if (_showMessage != value) {
      setState(() {
        _showMessage = value;
      });
    }
  }

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MenuBar(
                children: MenuEntry.build(_getMenus()),
              ),
            ),
          ],
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
                    showingMessage ? widget.message : '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(_lastSelection != null
                    ? 'Last Selected: $_lastSelection'
                    : ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<MenuEntry> _getMenus() {
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'Menu Demo',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'About',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'MenuBar Sample',
                applicationVersion: '1.0.0',
              );
              setState(() {
                _lastSelection = 'About';
              });
            },
          ),
          MenuEntry(
            label: showingMessage ? 'Hide Message' : 'Show Message',
            onPressed: () {
              setState(() {
                _lastSelection =
                    showingMessage ? 'Hide Message' : 'Show Message';
                showingMessage = !showingMessage;
              });
            },
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyS, control: true),
          ),
          // Hides the message, but is only enabled if the message isn't
          // already hidden.
          MenuEntry(
            label: 'Reset Message',
            onPressed: showingMessage
                ? () {
                    setState(() {
                      _lastSelection = 'Reset Message';
                      showingMessage = false;
                    });
                  }
                : null,
            shortcut: const SingleActivator(LogicalKeyboardKey.escape),
          ),
          MenuEntry(
            label: 'Background Color',
            menuChildren: <MenuEntry>[
              MenuEntry(
                label: 'Red Background',
                onPressed: () {
                  setState(() {
                    _lastSelection = 'Red Background';
                    backgroundColor = Colors.red;
                  });
                },
                shortcut: const SingleActivator(LogicalKeyboardKey.keyR,
                    control: true),
              ),
              MenuEntry(
                label: 'Green Background',
                onPressed: () {
                  setState(() {
                    _lastSelection = 'Green Background';
                    backgroundColor = Colors.green;
                  });
                },
                shortcut: const SingleActivator(LogicalKeyboardKey.keyG,
                    control: true),
              ),
              MenuEntry(
                label: 'Blue Background',
                onPressed: () {
                  setState(() {
                    _lastSelection = 'Blue Background';
                    backgroundColor = Colors.blue;
                  });
                },
                shortcut: const SingleActivator(LogicalKeyboardKey.keyB,
                    control: true),
              ),
            ],
          ),
        ],
      ),
    ];
    // (Re-)register the shortcuts with the ShortcutRegistry so that they are
    // available to the entire application, and update them if they've changed.
    _shortcutsEntry?.dispose();
    _shortcutsEntry =
        ShortcutRegistry.of(context).addAll(MenuEntry.shortcuts(result));
    return result;
  }
}

class MenuBar1 extends StatelessWidget {
  const MenuBar1({super.key});

  static const String kMessage = '"Talk less. Smile more." - A. Burr';

  @override
  Widget build(BuildContext context) {
    return const MyMenuBar(message: kMessage);
  }
}

// Example code from https://api.flutter.dev/flutter/material/MenuBar-class.html

/// Flutter code sample for [MenuAcceleratorLabel].
class MyMenuBar1 extends StatelessWidget {
  const MyMenuBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MenuBar(
                children: <Widget>[
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'MenuBar Sample',
                            applicationVersion: '1.0.0',
                          );
                        },
                        child: const MenuAcceleratorLabel(
                            '&About'), // &A - phím tắt: Alt + A
                      ),
                      MenuItemButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Saved!'),
                                duration: Duration(
                                    seconds:
                                        1)), // show 1s (chỉ chấp nhận int). Default 4s
                          );
                        },
                        child: const MenuAcceleratorLabel(
                            '&Save'), // &S - phím tắt: Alt + S
                      ),
                      MenuItemButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Quit!'),
                              duration: Duration(
                                  milliseconds: 500), // 0.5s. Default 4s
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('&Quit'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&File'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Magnify!'),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('&Magnify'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Minify!'),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel(
                            'Mi&nify'), // &N - phím tắt: Alt + N
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&View'),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: FlutterLogo(
            size: MediaQuery.of(context).size.shortestSide * 0.5,
          ),
        ),
      ],
    );
  }
}

class MenuBar2 extends StatelessWidget {
  const MenuBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyT, control: true):
            VoidCallbackIntent(() {
          debugDumpApp();
        }),
      },
      child: const MyMenuBar1(),
    );
  }
}
