import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// Cấu hình scroll bằng mouse
// bằng  MaterialApp(scrollBehavior: const MaterialScrollBehavior()

//
class MyRefreshIndicator1 extends StatelessWidget {
  const MyRefreshIndicator1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: const RefreshIndicatorExample1(),
    );
  }
}

class RefreshIndicatorExample extends StatefulWidget {
  const RefreshIndicatorExample({super.key});

  @override
  State<RefreshIndicatorExample> createState() =>
      _RefreshIndicatorExampleState();
}

class _RefreshIndicatorExampleState extends State<RefreshIndicatorExample> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicatorExample Sample'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        // Pull from top to show refresh indicator.

        child: ListView.builder(
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show refresh indicator programmatically on button tap.
          _refreshIndicatorKey.currentState?.show();
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Show Indicator'),
      ),
    );
  }
}

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

@override
Widget build(BuildContext context) {
  return RefreshIndicator(
    key: _refreshIndicatorKey,
    color: Colors.white,
    backgroundColor: Colors.blue,
    strokeWidth: 4.0,
    onRefresh: () async {
      // Replace this delay with the code to be executed during refresh
      // and return a Future when code finishes execution.
      return Future<void>.delayed(const Duration(seconds: 3));
    },
    // Pull from top to show refresh indicator.

    child: ListView.builder(
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    ),
  );
}
//-------------------------------------------

class RefreshIndicatorExample1 extends StatelessWidget {
  const RefreshIndicatorExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicatorExample1 Sample'),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return asynchronous code
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        // This check is used to customize listening to scroll notifications
        // from the widget's children.
        //
        // By default this is set to `notification.depth == 0`, which ensures
        // the only the scroll notifications from the first scroll view are listened to.
        //
        // Here setting `notification.depth == 1` triggers the refresh indicator
        // when overscrolling the nested scroll view.
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 1;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                color: Colors.pink[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Pull down here',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text("RefreshIndicator won't trigger"),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.green[100],
                height: 300,
                child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return const ListTile(
                      title: Text('Pull down here'),
                      subtitle: Text('RefreshIndicator will trigger'),
                    );
                  },
                ),
              ),
            ),
            SliverList.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const ListTile(
                    title: Text('Pull down here'),
                    subtitle: Text("Refresh indicator won't trigger"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
