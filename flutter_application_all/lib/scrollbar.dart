import 'dart:ui';

import 'package:flutter/material.dart';
/* 
scrollDirection = Axis.vertical, (default) - cuộn bằng con lăn chuột 
scrollDirection = Axis.horizontal, - cuộn bằng Shift + con lăn chuột 

thanh trượt dọc - auto show
thanh trượt ngang - phải bao SingleChildScrollView bằng Scrollbar và set thuộc tính   interactive: true, // Cho phép người dùng tương tác với thanh cuộn

 */

class MyScrollbar extends StatelessWidget {
  const MyScrollbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Scrollbar  Sample')),
        body: const Scrollbar05(),
      ),
    );
  }
}

// Scrollbar bao SingleChildScrollView
class Scrollbar01 extends StatefulWidget {
  const Scrollbar01({Key? key}) : super(key: key);

  @override
  _Scrollbar01State createState() => _Scrollbar01State();
}

class _Scrollbar01State extends State<Scrollbar01> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dọn dẹp ScrollController khi không còn cần thiết
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController, // Gán ScrollController cho Scrollbar
      scrollbarOrientation:
          ScrollbarOrientation.bottom, // Đặt thanh cuộn nằm dưới cùng
      thickness: 12, // Độ dày của thanh cuộn
      radius: const Radius.circular(4), // Bo góc cho thanh cuộn
      interactive: true, // Cho phép người dùng tương tác với thanh cuộn
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Cuộn theo chiều ngang
        controller:
            _scrollController, // Gán cùng một ScrollController cho SingleChildScrollView
        child: Row(
          children: List.generate(
            20,
            (index) => Container(
              width: 200.0, // Độ rộng của mỗi item
              height: 250.0, // Chiều cao của mỗi item
              color: Colors.primaries[
                  index % Colors.primaries.length], // Màu sắc của mỗi item
              child: Center(
                child: Text(
                  'Item $index',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20), // Cấu hình văn bản
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Scrollbar bao GridView
/* Khi thumbVisibility là true, thanh cuộn thumb sẽ vẫn hiển thị mà không có hiệu ứng mờ dần. Điều này yêu cầu phải cung cấp ScrollController cho bộ điều khiển hoặc PrimaryScrollController khả dụng. */
class Scrollbar02 extends StatefulWidget {
  const Scrollbar02({super.key});

  @override
  State<Scrollbar02> createState() => _Scrollbar02State();
}

class _Scrollbar02State extends State<Scrollbar02> {
  final ScrollController _controllerOne = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controllerOne,
      thumbVisibility: true,
      child: GridView.builder(
        scrollDirection: Axis.horizontal, // Cuộn theo chiều ngang
        controller: _controllerOne,
        itemCount: 80,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text('item $index'),
          );
        },
      ),
    );
  }
}

// Scrollbar bao GridView
/* hiển thị một thanh cuộn thực hiện hoạt ảnh mờ dần khi cuộn xảy ra. Thanh cuộn sẽ mờ dần khi người dùng cuộn và mờ dần khi dừng cuộn. */
class Scrollbar03 extends StatelessWidget {
  const Scrollbar03({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        primary: true,
        itemCount: 120,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text('item $index'),
          );
        },
      ),
    );
  }
}

// Hai SizedBox > Scrollbar > ListView
// Mẫu này cho thấy cách vô hiệu hóa Thanh cuộn mặc định cho tiện ích có thể cuộn để tránh trùng lặp Thanh cuộn khi chạy trên nền tảng máy tính để bàn.
class Scrollbar04 extends StatefulWidget {
  const Scrollbar04({super.key});

  @override
  State<Scrollbar04> createState() => _Scrollbar04State();
}

class _Scrollbar04State extends State<Scrollbar04> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          SizedBox(
              width: constraints.maxWidth / 2,
              // When running this sample on desktop, two scrollbars will be
              // visible here. One is the default scrollbar and the other is the
              // Scrollbar widget with custom thickness.
              child: Scrollbar(
                thickness: 20.0,
                thumbVisibility: true,
                controller: controller,
                child: ListView.builder(
                  controller: controller,
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Scrollable 1 : Index $index'),
                      ),
                    );
                  },
                ),
              )),
          SizedBox(
              width: constraints.maxWidth / 2,
              // When running this sample on desktop, one scrollbar will be
              // visible here. The default scrollbar is hidden by setting the
              // ScrollConfiguration's scrollbars to false. The Scrollbar widget
              // with custom thickness is visible.
              /*
              Để vô hiệu hóa thanh cuộn mặc định, bạn sử dụng ScrollConfiguration với behavior được sao chép từ cấu hình hiện tại nhưng với scrollbars được đặt thành false: 
               */
              child: Scrollbar(
                thickness: 20.0,
                thumbVisibility: true,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    primary: true,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Scrollable 2 : Index $index'),
                        ),
                      );
                    },
                  ),
                ),
              )),
        ],
      );
    });
  }
}

// Hai SizedBox > Scrollbar > ListView
/* 
+ ScrollController: là một đối tượng dùng để điều khiển và theo dõi vị trí cuộn của các widget cuộn như SingleChildScrollView. Nó giúp bạn quản lý vị trí cuộn và lắng nghe các sự kiện cuộn.
ScrollController Tùy Chỉnh: Nếu không sử dụng thuộc tính primary, bạn cần gán 1 ScrollController cho thuộc tính controller của Scrollbar

+ PrimaryScrollController: tương đương như ScrollController.
Trên nền tảng di động, PrimaryScrollController tự động đính kèm vào các ScrollView dọc (vertical scroll views) mà ko cần cấu hình thêm. Trên nền tảng máy tính để bàn, PrimaryScrollController phải được chỉ định bằng thuộc tính primary.
primary: true: Thuộc tính này yêu cầu ListView sử dụng PrimaryScrollController.

Sử Dụng ScrollController Tùy Chỉnh: Để quản lý cuộn cho ListView đầu tiên và tránh xung đột với PrimaryScrollController.
Sử Dụng PrimaryScrollController: cho ListView thứ hai với thuộc tính primary: true, chỉ thị đính kèm PrimaryScrollController.

Sự Khác Biệt
Với ScrollController:

Quản lý Cuộn: ScrollController cho phép bạn kiểm soát nhiều hơn đối với hành vi cuộn. Bạn có thể điều khiển cuộn từ mã, theo dõi vị trí cuộn, hoặc làm việc với các sự kiện cuộn.
Chia Sẻ ScrollController: Nếu bạn cần chia sẻ hoặc đồng bộ hóa cuộn giữa nhiều widget, bạn có thể sử dụng cùng một ScrollController.
Tùy Chỉnh: Bạn có thể tùy chỉnh các thuộc tính của ScrollController, như tốc độ cuộn hoặc hành vi cuộn.
Không sử dụng ScrollController:

Sử Dụng PrimaryScrollController: ListView sử dụng PrimaryScrollController mặc định của Flutter. Điều này đơn giản hóa mã của bạn nhưng có ít quyền kiểm soát hơn so với khi sử dụng ScrollController tùy chỉnh.
Dễ Sử Dụng: Phương pháp này dễ dàng hơn cho các ứng dụng đơn giản mà không yêu cầu kiểm soát cuộn đặc biệt hoặc không cần chia sẻ ScrollController giữa nhiều widget.
 */

class Scrollbar05 extends StatefulWidget {
  const Scrollbar05({super.key});

  @override
  State<Scrollbar05> createState() => _Scrollbar05State();
}

class _Scrollbar05State extends State<Scrollbar05> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: <Widget>[
          SizedBox(
              width: constraints.maxWidth / 2,
              // When using the PrimaryScrollController and a Scrollbar
              // together, only one ScrollPosition can be attached to the
              // PrimaryScrollController at a time. Providing a
              // unique scroll controller to this scroll view prevents it
              // from attaching to the PrimaryScrollController.
              child: Scrollbar(
                thumbVisibility: true,
                controller: _firstController,
                child: ListView.builder(
                    controller: _firstController,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Scrollable 1 : Index $index'),
                      );
                    }),
              )),
          SizedBox(
              width: constraints.maxWidth / 2,
              // This vertical scroll view has primary set to true, so it is
              // using the PrimaryScrollController. On mobile platforms, the
              // PrimaryScrollController automatically attaches to vertical
              // ScrollViews, unlike on Desktop platforms, where the primary
              // parameter is required.
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                    primary: true,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          color: index.isEven
                              ? Colors.amberAccent
                              : Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Scrollable 2 : Index $index'),
                          ));
                    }),
              )),
        ],
      );
    });
  }
}
