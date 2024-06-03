import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Cấu hình scroll bằng mouse
// bằng  MaterialApp(scrollBehavior: const MaterialScrollBehavior()

// pull_to_refresh package cho phép set
class MyPullToRefresh extends StatelessWidget {
  const MyPullToRefresh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: const PullToRefresh(),
    );
  }
}

class PullToRefresh extends StatefulWidget {
  const PullToRefresh({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PullToRefresh> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> items = List<String>.generate(20, (i) => "Item $i");
// _onRefresh - call on kéo xuống
  void _onRefresh() async {
    // simulate network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

// _onLoading - call on kéo lên
  void _onLoading() async {
    // simulate network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        items.add((items.length + 1).toString());
      });
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull To Refresh Example'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header:
            const WaterDropHeader(), // setup hiệu ứng animation khi kéo xuống
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed! Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text(
                  "release to load more"); // notification when kéo tới đáy màn hình hết items mà chưa nhả chuột/cảm ứng
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 80.0,
          itemCount: items.length,
        ),
      ),
    );
  }
}
//------------------------------------------------
