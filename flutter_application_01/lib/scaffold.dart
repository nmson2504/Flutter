import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      home: Scaffold(
          body:
              Home6A()), // Để call Home6A ưidget required đặt Scaffold tại đây
    );
  }
}

// Home1 - floatingActionButton
class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Column(children: [
        const Text('Home'),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 164, 208, 182)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Screen1()));
            },
            child: const Text('Screen 1')),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Screen2()));
            },
            child: const Text('Screen 2')),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Screen2()));
        },
        tooltip: 'FloatingActionButton',
        shape: const RoundedRectangleBorder(), // set hình dạng
        child: const Icon(Icons.add),
      ),
      // set vị trí của FloatingActionButton
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1')),
      body: Center(
          child: Column(children: [
        const Text('Screen 1'),
        ElevatedButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Return to Home Screen')),
      ])),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Screen 2')),
        body: Center(
            child: Column(children: [
          const Text('Screen 2'),
          ElevatedButton(
              style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Return to Home Screen')),
        ])));
  }
}

// Home2 - bottomNavigationBar: BottomNavigationBar

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int _selectedIndex = 0; // set index default khi load layout
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // List các option trên BottomNavigationBar
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample 2'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(
            _selectedIndex), // show object trong list _widgetOptions ở trên. Khi onTap:
        // _onItemTapped sẽ auto reload widget theo _selectedIndex
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex, // set default selected index
        selectedItemColor: Colors.amber[800], // set color for selected item
        onTap:
            _onItemTapped, // call function _onItemTapped update _selectedIndex
      ),
    );
  }
}
// Home2A - BottomNavigationBarType - xem comment bên dưới

class Home2A extends StatefulWidget {
  const Home2A({super.key});

  @override
  State<Home2A> createState() => _Home2AState();
}

class _Home2AState extends State<Home2A> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample 2A'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        /// set type of BottomNavigationBarType - fixed or shifting. Default is fixed, if item > 3 auto switch to shifting. Nếu muốn dùng shifting thì phải set backgroundColor cho 1 or mỗi item
        /// Nếu ko muốn BottomNavigationBarType auto switch thì set type: BottomNavigationBarType thủ công
        // type: BottomNavigationBarType.shifting,
        showUnselectedLabels:
            true, // luôn show label của item ko được chọn trong chế độ shifting
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Home3 - bottomNavigationBar: BottomNavigationBar - show page theo index - ko cần dùng Navigator

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  _Home3State createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    FirstPage(),
    SecondPage(),
    ThirdPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Demo'),
      ),
      body: _pages[
          _selectedIndex], // show page theo index - ko cần dùng Navigator
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // list các item trên BottomNavigationBar
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex, // set default selected index
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Business Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('School Page'),
    );
  }
}

// Home4 - bottomNavigationBar: NavigationBar

class Home4 extends StatefulWidget {
  const Home4({super.key});

  @override
  State<Home4> createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          // call function onDestinationSelected update currentPageIndex, render lại widget
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 249, 207, 153),
        selectedIndex: currentPageIndex, // set default selected index
        destinations: const <Widget>[
          // list các item trên NavigationBar
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ),
      body: <Widget>[
        // body của Scaffold là list các page được định nghĩa bằng các Container
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

// Home5 - persistentFooterButtons

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

class Home5 extends StatelessWidget {
  const Home5({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      // DefaultTabController - để tạo TabBar
      initialIndex: 0, // initialIndex - để chọn tab mặc định
      length: tabsCount, // length - số lượng tab
      child: Scaffold(
        persistentFooterButtons: [
          // persistentFooterButtons - tạo list các button fixed ở cuối màn hình
          ElevatedButton(
            onPressed: () {},
            child: const Text('Button 1'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Button 2'),
          ),
        ],
        persistentFooterAlignment: AlignmentDirectional
            .center, // set vị trí của persistentFooterButtons
        appBar: AppBar(
          title: const Text('AppBar Sample'),
          // This check specifies which nested Scrollable's scroll notification
          // should be listened to.
          //
          // When `ThemeData.useMaterial3` is true and scroll view has
          // scrolled underneath the app bar, this updates the app bar
          // background color and elevation.
          //
          // This sets `notification.depth == 1` to listen to the scroll
          // notification from the nested `ListView.builder`.
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation:
              10.0, // scrolledUnderElevation - độ nâng bóng của appbar khi scroll
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            // bottom của AppBar - tạo TabBar dưới AppBar
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.brightness_5_sharp),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          // body của Scaffold - tạo TabBarView cho TabBar
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[0]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[1]} $index'),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: Text('${titles[2]} $index'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Home5A - bottomSheet - widget nằm cố định ở bottom -  xem comment bên dưới

class Home5A extends StatelessWidget {
  const Home5A({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home5A - bottomSheet'),
      ),
      body: const Center(
        child: Text('Your Screen Content'),
      ),
      bottomSheet: Container(
        // bottomSheet - cố định ở cuối màn hình
        padding: const EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('This is a bottom sheet',
                style: TextStyle(color: Colors.white)),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi nút trên bottom sheet được nhấn
              },
              child:
                  const Text('Action', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// Home6 - showModalBottomSheet -  - hiển thị bottom sheet, click ra ngoài bottom sheet để đóng bottom sheet
class Home6 extends StatelessWidget {
  const Home6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home6 - showModalBottomSheet'),
      ),
      body: const Center(
        child: Text('Your Screen Content'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Hiển thị BottomSheet khi nhấn vào FloatingActionButton
          showModalBottomSheet(
            // showModalBottomSheet - hiển thị bottom sheet, click ra ngoài bottom sheet để đóng bottom sheet
            context: context,
            builder: (BuildContext context) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    'This is a BottomSheet - call function showModalBottomSheet'),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Home6A - showBottomSheet -  show bottom sheet trên 1 page mới, ko đóng được bottom sheet ở trang này

class Home6A extends StatelessWidget {
  const Home6A({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Khi nút được nhấn, hiển thị Bottom Sheet
            showBottomSheet(
              // show bottom sheet trên 1 page mới, ko đóng được bottom sheet ở trang này
              // lỗi FlutterError (No Scaffold widget found.
// Home6A widgets require a Scaffold widget ancestor. Để xly this error phải đặt Scaffold ngoài widget này (widget cha của this widget)
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'This is a Bottom Sheet!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

// 