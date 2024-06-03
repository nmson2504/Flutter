import 'package:flutter/material.dart';

class MyPopupMenuButton extends StatelessWidget {
  const MyPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('PopupMenuButton  Sample')),
        body: const PopupMenuButton2(),
      ),
    );
  }
}

//
class PopupMenuButton1 extends StatelessWidget {
  const PopupMenuButton1({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // required PopupMenuItemBuilder<T> itemBuilder
      itemBuilder: (BuildContext context) {
        return <String>['Option 1', 'Option 2', 'Option 3']
            .map((String choice) {
          return PopupMenuItem<String>(
            value:
                choice, // The value that will be returned by [showMenu] if this entry is selected.
            child: Text(choice),
          );
        }).toList();
      },
      initialValue: 'Option 2', // choice value mặc định
      tooltip: 'Click vào', // tooltip khi on hover icon popup menu
      // icon: const Icon(Icons.abc), // icon của popup menu, mặc định là dấu 3 chấm
      onSelected: (String choice) {
        debugPrint('You selected: $choice');
      },
      // child: tương đương thuộc tính icon: của PopupMenuButton (ko phải child của PopupMenuItem)
      // One of child or icon may be provided, but not both
      child: const Icon(Icons.access_alarms),
    );
  }
}

//
class PopupMenuButton3 extends StatefulWidget {
  // const PupupMenuButton3({super.key});

  const PopupMenuButton3({super.key});

  @override
  State<PopupMenuButton3> createState() => _PopupMenuButton3State();
}

class _PopupMenuButton3State extends State<PopupMenuButton3> {
  List<IconData> listIcon = [Icons.alarm, Icons.mail, Icons.cabin];
  List<String> listItem = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // required PopupMenuItemBuilder<T> itemBuilder
      itemBuilder:
          // Không cần tham số context
          (_) {
        return listItem.map((String choice) {
          return PopupMenuItem<String>(
            value:
                choice, // The value that will be returned by [showMenu] if this entry is selected.
            child: Row(
              children: [
                Icon(listIcon[listItem.indexOf(choice)]),
                Text(choice),
              ],
            ),
          );
        }).toList();
      },
      initialValue: 'Option 2', // choice value mặc định
      tooltip: 'Click vào', // tooltip khi on hover icon popup menu
      // icon: const Icon(Icons.abc), // icon của popup menu, mặc định là dấu 3 chấm
      onSelected: (String choice) {
        debugPrint('You selected: $choice');
        // index =
        //     -1; // ko hiểu sao index load lần đầu xong giữ value cao nhất luôn - phải reset lại sau mõi lần click
      },
    );
  }
}

//
class PopupMenuButton2 extends StatefulWidget {
  const PopupMenuButton2({super.key});

  @override
  State<PopupMenuButton2> createState() => _PopupMenuButton2State();
}

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

class _PopupMenuButton2State extends State<PopupMenuButton2> {
  SampleItem? selectedMenu;
  // phải convert enum -> list rồi mới .map được
  final List<SampleItem> listSampleItem = SampleItem.values.toList();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        // Callback that sets the selected popup menu item.
        onSelected: (SampleItem item) {
          setState(() {
            selectedMenu = item;
            debugPrint('$selectedMenu');
          });
        },
        itemBuilder: (_) {
          return listSampleItem.map((SampleItem item) {
            return PopupMenuItem<SampleItem>(
              value: item,
              child: Text(item.name),
            );
          }).toList();
        });
  }
}
