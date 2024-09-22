import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MyExpansionPanel extends StatelessWidget {
  const MyExpansionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter ExpansionPanelList')),
        body: const ExpansionPanelExample(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

// Example 1

class ExpansionPanelExample extends StatefulWidget {
  const ExpansionPanelExample({super.key});

  @override
  _ExpansionPanelExampleState createState() => _ExpansionPanelExampleState();
}

class _ExpansionPanelExampleState extends State<ExpansionPanelExample> {
  List<Item> _data = generateItems(3); // Tạo 3 item cho ví dụ

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ExpansionPanelList thường
          ExpansionPanelList(
            /* 
            - expansionCallback nhận hai tham số: chỉ mục của panel và trạng thái mở rộng hiện tại của panel.
             - tham số isExpanded trong expansionCallback: (int index, bool isExpanded) được Flutter tự động xác định dựa trên trạng thái hiện tại của panel khi người dùng nhấp vào nút mở/đóng. Nếu panel đang mở (isExpanded = true), tham số sẽ được gán true, và nếu đang đóng, nó sẽ là false. Trách nhiệm của callback là cập nhật trạng thái này trong mã nguồn (thường qua setState), để giao diện có thể phản hồi chính xác với hành động của người dùng.
             */
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              // map list items vào list ExpansionPanel
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                  title: Text(item.expandedValue),
                ),
                // isExpanded: item.isExpanded thực hiện việc mở (expanded) hoặc đóng (collapse) panel đó dựa trên trạng thái hiện tại của item.isExpanded
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.amber,
          ),
          // ExpansionPanelList.radio
          ExpansionPanelList.radio(
            children: _data.map<ExpansionPanelRadio>((Item item) {
              return ExpansionPanelRadio(
                value: item.headerValue,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                  title: Text(item.expandedValue),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

// Example 2 - delete item với  _data.removeWhere
class ExpansionPanelListExampleApp extends StatelessWidget {
  const ExpansionPanelListExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpansionPanelListExample();
  }
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  State<ExpansionPanelListExample> createState() => _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
