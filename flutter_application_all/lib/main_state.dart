import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text('My App 001'),
              ),
              body: const Center(child: MyWidgetFul(true))))));
}

// StatelessWidget
class MyWidgetLes extends StatelessWidget {
  final bool load_state;
  const MyWidgetLes(this.load_state, {super.key});
  @override
  Widget build(BuildContext context) {
    return load_state
        ? Text('loading state $load_state')
        : const CircularProgressIndicator();
  }
}

// StatefulWidget
class MyWidgetFul extends StatefulWidget {
  final bool loading;
  const MyWidgetFul(this.loading, {super.key});

  @override
  State<StatefulWidget> createState() {
    return MyWidgetFul_state();
  }
}

class MyWidgetFul_state extends State<MyWidgetFul> {
  late bool _local_load_state;
  @override
  void initState() {
    // khoi tao gia tri ban dau, run truoc build function
    _local_load_state = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return _local_load_state
        ? const Text('StatefulWidget')
        : const CircularProgressIndicator();
  }
}
