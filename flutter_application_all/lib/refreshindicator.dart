import 'dart:ui';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// Class cấu hình scroll bằng mouse
// Bước 1: Định nghĩa class cấu hình
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch, // cảm ứng
        PointerDeviceKind.mouse, // vuốt màn hình bằng chuột. default ko có
        // etc.
      };
}

/* 
Bước 2: Áp dụng cấu hình
Tại Widget build thêm như dưới đây
Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
child: GridView.count(……..

 */

// //-----------------------

//
class MyRefreshIndicator extends StatelessWidget {
  const MyRefreshIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RefreshIndicatorExample_B(),
    );
  }
}

class RefreshIndicatorExample_A extends StatefulWidget {
  const RefreshIndicatorExample_A({super.key});

  @override
  State<RefreshIndicatorExample_A> createState() =>
      _RefreshIndicatorExampleState();
}

class _RefreshIndicatorExampleState extends State<RefreshIndicatorExample_A> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

/* GlobalKey là một cách để định danh một widget trong cả cây widget của ứng dụng.
 Trong trường hợp này, GlobalKey được sử dụng để lấy ra RefreshIndicatorState, cho phép bạn gọi các phương thức của RefreshIndicator từ bên ngoài nơi nó được khai báo. */
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('RefreshIndicatorExample_A Sample'),
          ),
          body: RefreshIndicator(
            key:
                _refreshIndicatorKey, // Thuộc tính này được sử dụng để xác định một khóa duy nhất cho widget, giúp Flutter xác định widget mỗi khi cần thiết.
            color: Colors.white, //  Màu sắc của chỉ báo tiến trình tròn.
            backgroundColor:
                Colors.blue, // Màu nền của chỉ báo tiến trình tròn.
            strokeWidth: 4.0, // Độ dày của vòng tròn chỉ báo tiến trình
            // onRefresh - RefreshCallback required
            onRefresh: () async {
              // Replace this delay with the code to be executed during refresh
              // and return a Future when code finishes execution.
              return Future<void>.delayed(
                  const Duration(seconds: 2)); // set time show RefreshIndicator
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
              /*gọi phương thức show() của RefreshIndicator, từ đó hiển thị chỉ báo làm mới trên màn hình. 
              Việc sử dụng toán tử ?. ở đây giúp kiểm tra xem currentState có khác null không trước khi gọi phương thức show(), 
              nhằm tránh lỗi nếu currentState không tồn tại. 
               */
              _refreshIndicatorKey.currentState?.show();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Show Indicator'),
          ),
        ));
  }
}

//-------------------------------------------

class RefreshIndicatorExample_B extends StatelessWidget {
  const RefreshIndicatorExample_B({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('RefreshIndicatorExample_B Sample'),
          ),
          body: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.blue,
            onRefresh: () async {
              // Replace this delay with the code to be executed during refresh
              // and return asynchronous code
              return Future<void>.delayed(const Duration(seconds: 2));
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
              return notification.depth ==
                  1; // set trigger trên SliverToBoxAdapter thứ 2 của CustomScrollView
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
        ));
  }
}
