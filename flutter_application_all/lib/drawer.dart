import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Drawer03(),
      // backgroundColor: Color.fromARGB(255, 235, 217, 163),
    );
  }
}

//---------------------------
// // endDrawer - dựng list items on right side; drawer - dựng list items on left side
class Drawer01 extends StatelessWidget {
  const Drawer01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold with endDrawer'),
      ),
      body: const Center(
        child: Text('Main Content'),
      ),
      // endDrawer - dựng list items on right side; drawer - dựng list items on left side
      endDrawer: Drawer(
        // The content of the endDrawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'End Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // The content of the endDrawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------------------------
// Using Scaffold.of(context).openEndDrawer/openDrawer();
class Drawer02 extends StatelessWidget {
  const Drawer02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold with openEndDrawer'),
      ),
      body: Center(
        /// Scaffold.of(context) requires a BuildContext from the subtree of the widget tree that includes the Scaffold. If the ElevatedButton is not within the subtree of the Scaffold, it won't be able to find the scaffold using Scaffold.of(context).
        child: Builder(builder: (context) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Open the end drawer programmatically
                  Scaffold.of(context).openEndDrawer();
                },
                child: const Text('Using openEndDrawer'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Open the end drawer programmatically
                  Scaffold.of(context).openDrawer();
                },
                child: const Text('Using openDrawer'),
              ),
            ],
          );
        }),
      ),
      endDrawer: Drawer(
        // The content of the endDrawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'End Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // The content of the endDrawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------------------------
// Change content page corresponding item menu

class Drawer03 extends StatefulWidget {
  const Drawer03({super.key});

  @override
  State<Drawer03> createState() => _Drawer03State();
}

class _Drawer03State extends State<Drawer03> {
  String selectedPage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Example'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                setState(() {
                  selectedPage = 'Messages';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  selectedPage = 'Profile';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  selectedPage = 'Settings';
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Page: $selectedPage'),
      ),
    );
  }
}

//----------------------------------------------------------------
// NavigationDrawer
// On top of Drawers, Navigation drawers offer a persistent and convenient way to switch between primary destinations in an app.

class NavigationDrawer01 extends StatefulWidget {
  const NavigationDrawer01({super.key});

  @override
  State<NavigationDrawer01> createState() => _NavigationDrawer01State();
}

class _NavigationDrawer01State extends State<NavigationDrawer01> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Bottom Navigation Drawer Demo - switch to corresponding page'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const <Widget>[
          // children classes is defined in bottom
          HomePageContent(),
          SettingsPageContent(),
          AboutPageContent(),
        ],
      ),
      bottomNavigationBar: NavigationDrawer(
        // class NavigationDrawer is defined in bottom
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavigationDrawer(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page Content'),
    );
  }
}

class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page Content'),
    );
  }
}

class AboutPageContent extends StatelessWidget {
  const AboutPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('About Page Content'),
    );
  }
}

//
// Update contains in 1 page

class NavigationDrawer02 extends StatelessWidget {
  final GlobalKey<_HomePageContentState> _homePageKey = GlobalKey();

  NavigationDrawer02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Drawer Demo - update only 1 page'),
      ),
      body: HomePageContentA(
          key: _homePageKey), // class HomePageContentA is defined in bottom
      bottomNavigationBar: NavigationDrawerA(
          homePageKey:
              _homePageKey), // class NavigationDrawerA is defined in bottom
    );
  }
}

class NavigationDrawerA extends StatelessWidget {
  final GlobalKey<_HomePageContentState> homePageKey;

  const NavigationDrawerA({super.key, required this.homePageKey});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        // You can perform actions based on the tapped item index if needed
        // For example, you can update a state variable in the HomePageContent
        // and trigger a rebuild.
        homePageKey.currentState?.updateContent(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
    );
  }
}

class HomePageContentA extends StatefulWidget {
  const HomePageContentA({Key? key}) : super(key: key);

  @override
  State<HomePageContentA> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContentA> {
  String content = 'Home Page Content';

  void updateContent(int index) {
    setState(() {
      // Update the content based on the tapped item index
      if (index == 1) {
        content = 'Settings Page Content';
      } else if (index == 2) {
        content = 'About Page Content';
      } else {
        content = 'Home Page Content';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(content),
    );
  }
}
