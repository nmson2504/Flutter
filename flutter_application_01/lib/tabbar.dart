import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true), home: const Home3());
  }
}

// Home1 - Use DefaultTabController

class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // DefaultTabController ancestor must be provided instead if TabController is not provided
      initialIndex: 0, // initial index of the tab
      length: 3, // length of tabs list
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          // The tab controller's TabController.length must equal the length of the TabBar.tabs and the length of the TabBarView.children list.
          bottom: const TabBar(
            // Typically TabBar created as the AppBar.bottom
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
// Home2 - User TabController

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

/// [AnimationController]s can be created with `vsync: this` because of [TickerProviderStateMixin].
class _Home2State extends State<Home2> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // setup the tab controller
  }

  /// _tabController.dispose();: The TabController is an object that manages the state of a TabBar and TabBarView. It should be disposed of when it's no longer needed to release any resources it may be holding.
  /// super.dispose();: This calls the dispose method of the superclass (State) to ensure that any additional cleanup required by the superclass is performed.
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Sample'),
        bottom: TabBar(
          controller:
              _tabController, // set TabBar.controller and TabBarView.controller (below) when using TabController
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
              text: 'data.cloud_outlined',
            ),
            Tab(
              icon: Icon(Icons.beach_access_sharp),
              text: 'data.beach_access_sharp',
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
              text: 'data.brightness_5_sharp',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}

// Home3 -
// This sample showcases nested Material 3 TabBars. It consists of a primary TabBar with nested a secondary TabBar. The primary TabBar uses a DefaultTabController while the secondary TabBar uses a TabController.

class Home3 extends StatelessWidget {
  const Home3({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Primary and secondary TabBar'),
          bottom: const TabBar(
            dividerColor: Color.fromARGB(0, 57, 60, 238),
            tabs: <Widget>[
              Tab(
                text: 'Flights',
                icon: Icon(Icons.flight),
              ),
              Tab(
                text: 'Trips',
                icon: Icon(Icons.luggage),
              ),
              Tab(
                text: 'Explore',
                icon: Icon(Icons.explore),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            NestedTabBar('Flights'), // NestedTabBar definition below
            NestedTabBar('Trips'),
            NestedTabBar('Explore'),
          ],
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // setup the tab controller
  }

  /// _tabController.dispose();: The TabController is an object that manages the state of a TabBar and TabBarView. It should be disposed of when it's no longer needed to release any resources it may be holding.
  /// super.dispose();: This calls the dispose method of the superclass (State) to ensure that any additional cleanup required by the superclass is performed.
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          // first child is the TabBar
          // set TabBar.secondary
          controller:
              _tabController, // set TabBar.controller and TabBarView.controller (below) when using TabController
          tabs: const <Widget>[
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          // second child is the TabBarView
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(16.0),

                ///Trong Flutter, thuộc tính widget được sử dụng để tham chiếu đến widget hiện tại trong lớp State của một widget StatefulWidget cụ thể. Nó tham chiếu đến instance của widget mà State đang quản lý. Điều này xảy ra vì lớp State và widget là một cặp - mỗi lần bạn tạo một widget StatefulWidget, một State object riêng biệt được tạo và gắn liền với widget đó.
                ///Trong trường hợp của mã Flutter bạn đã cung cấp, khi bạn tạo một NestedTabBar, widget đó được tạo và có một State object tương ứng được tạo. Do đó, trong phương thức build của NestedTabBar, bạn có thể sử dụng widget để tham chiếu đến widget hiện tại, và widget.outerTab để truy cập giá trị của thuộc tính outerTab đã được cung cấp qua hàm khởi tạo.
                /// Khi bạn tạo một NestedTabBar, bạn cung cấp một giá trị outerTab thông qua hàm khởi tạo, và giá trị này được lưu trong thuộc tính outerTab của widget. Sau đó, trong phần build, bạn sử dụng widget.outerTab để truy cập giá trị outerTab đó và hiển thị nó trong văn bản.
                child: Center(child: Text('${widget.outerTab}: Overview tab')),
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text('${widget.outerTab}: Specifications tab')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
