import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter PageView')),
        body: const PageViewExample(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}
//---------------------------

class PageView1 extends StatelessWidget {
  const PageView1({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      reverse: true, // reverse order pages
      children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        ),
      ],
    );
  }
}

// PageView2 - PageView.builder - Creates a scrollable list that works page by page using widgets that are created on demand.
class PageView2 extends StatelessWidget {
  const PageView2({super.key});

  static const List<String> imageUrls = [
    'https://images.pexels.com/photos/276267/pexels-photo-276267.jpeg',
    'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg',
    'https://images.pexels.com/photos/34299/herbs-flavoring-seasoning-cooking.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount:
          imageUrls.length, // tránh lỗi: RangeError (RangeError (index): Invalid value: Not in inclusive range 0....)
      itemBuilder: (context, index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.scaleDown,
        );
      },
    );
  }
}

//  PageController.initialPage - set the initial page
class PageView3 extends StatelessWidget {
  const PageView3({super.key});
  static const List<String> imageUrls = [
    'https://images.pexels.com/photos/276267/pexels-photo-276267.jpeg',
    'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg',
    'https://images.pexels.com/photos/34299/herbs-flavoring-seasoning-cooking.jpg',
  ];

  static final PageController _pageController =
      PageController(initialPage: 2); //PageController.initialPage - set the initial page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

// PageView.custom

class PageView4 extends StatelessWidget {
  const PageView4({super.key});
  static final List<String> data = ['Page 1', 'Page 2', 'Page 3'];

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        // required
        (context, index) {
          return Container(
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            alignment: Alignment.center,
            child: Text(
              data[index],
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        },
        childCount:
            data.length, // tránh lỗi: RangeError (RangeError (index): Invalid value: Not in inclusive range 0...)
      ),
      onPageChanged: (index) {
        // whenever the page changes
        debugPrint('Page changed to: $index');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('This is a ${data[index]}'), duration: const Duration(seconds: 1)));
      },
      controller: PageController(initialPage: 1),
    );
  }
}

// demo from https://api.flutter.dev/flutter/widgets/PageView-class.html - có thanh điều hướng bottom - Page indicator for desktop and web platforms.
class PageViewExample extends StatefulWidget {
  const PageViewExample({super.key});

  @override
  State<PageViewExample> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[
            Center(
              child: Text('First Page', style: textTheme.titleLarge),
            ),
            Center(
              child: Text('Second Page', style: textTheme.titleLarge),
            ),
            Center(
              child: Text('Third Page', style: textTheme.titleLarge),
            ),
          ],
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          isOnDesktopAndWeb: _isOnDesktopAndWeb,
        ),
      ],
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

/// Page indicator for desktop and web platforms.
///
/// On Desktop and Web, drag gesture for horizontal scrolling in a PageView is disabled by default.
/// You can defined a custom scroll behavior to activate drag gestures,
/// see https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag.
///
/// In this sample, we use a TabPageSelector to navigate between pages,
/// in order to build natural behavior similar to other desktop applications.
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
