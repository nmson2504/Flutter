import 'dart:async';

import 'package:flutter/material.dart';

import 'count_down_page_2.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({super.key, required this.seconds});

  final int seconds;

  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage> {
  /* lưu trữ thời gian đếm ngược hiện tại. Biến này được khởi tạo với giá trị mặc định là 0 và sau đó sẽ được cập nhật với giá trị thời gian mà người dùng cung cấp (widget.seconds) thông qua phương thức setTime(). */
  int _start = 0;
//StreamController này để quản lý dữ liệu thời gian đếm ngược.
  final StreamController<int> _timeStreamController = StreamController();
  Stream<int> get _timeStream => _timeStreamController.stream; //  getter để lấy ra stream từ _timeStreamController.

/* StreamSubscription cho phép lắng nghe và theo dõi các giá trị mà stream phát ra. Biến này sẽ lưu trữ tham chiếu đến việc đăng ký lắng nghe timeStream, giúp kiểm soát các thao tác như tạm dừng, tiếp tục, hoặc hủy đăng ký khi không còn cần thiết. */
  StreamSubscription? _timeSubscription;
/* functionSubscription dùng để quản lý việc lắng nghe các sự kiện khác nhau như Start, Pause, Resume, và Reset từ một stream khác (do _functionController phát ra). */
  late StreamSubscription _functionSubscription;
// StreamController này để quản lý các sự kiện bắt đầu, tạm dừng, tiếp tục và đặt lại đếm ngược.
  final StreamController<CountDownEvent> _functionController = StreamController.broadcast();
/* Phương thức setTime cho phép cài đặt thời gian đếm ngược bắt đầu.
Tham số time là tùy chọn (int?), và nếu nó không được truyền vào, phương thức sẽ sử dụng giá trị mặc định từ widget.seconds (giá trị thời gian được truyền từ widget cha khi khởi tạo CountDownPage). */
  void setTime({int? time}) {
    _start = time ?? widget.seconds;
  }

  @override
  void initState() {
    super.initState();
    setTime();

    ///việc quản lý các sự kiện bằng stream ở đây
    ///giúp cho các công việc không thực hiện lại công việc nó đang thực hiện
    ///bằng hàm distinct()
    _functionSubscription = _functionController.stream.distinct().listen((event) {
      switch (event) {
        case CountDownEvent.start:
          _onStart();
          break;
        case CountDownEvent.pause:
          _onPause();
          break;
        case CountDownEvent.resume:
          _onResume();
          break;
        case CountDownEvent.reset:
          _onReset();
          break;
      }
    });
  }

  @override
  void dispose() {
    _timeSubscription?.cancel();
    _functionSubscription.cancel();
    _timeStreamController.close();
    _functionController.close();
    super.dispose();
  }

  void _onStart() {
    if (_timeSubscription != null) {
      _onReset();
    }
    // i is an integer that starts with 0 and is incremented for every event.
    // tham khảo D:\Dart\dart_application_1\bin\06_asynchronous_05a.dart
    /* 
    Tóm tắt luồng xử lý:
Stream.periodic: Tạo ra một stream phát ra sự kiện cứ mỗi giây.
(i) => _start - i: Tính toán giá trị bộ đếm ngược dựa trên chỉ số i (số lần sự kiện được phát ra) và giá trị _start (số giây ban đầu).
listen((event)): Nhận giá trị event từ stream và xử lý nó.
_timeStreamController.add(event): Truyền giá trị event vào StreamController, từ đó các listener khác (như StreamBuilder trong UI) có thể nhận được giá trị này để cập nhật giao diện (UI).
     */
    _timeSubscription = Stream.periodic(const Duration(seconds: 1), (i) => _start - i).listen(
      (event) {
        _timeStreamController.add(event); // Truyền giá trị event vào StreamController
        if (event == 0) {
          _onFinish();
        }
      },
    );
  }

  void _onResume() {
    if (_timeSubscription?.isPaused ?? false) { // .isPause: Returns a future that handles the [onDone] and [onError] callbacks.
      _timeSubscription?.resume();
    }
  }

  void _onPause() {
    if (!(_timeSubscription?.isPaused ?? true)) {
      _timeSubscription?.pause();
    }
  }

  void _onFinish() {
    _timeSubscription?.cancel();
    _timeSubscription = null;
  }

  void _onReset() {
    _timeSubscription?.cancel();
    _timeSubscription = null;
    _timeStreamController.add(_start); // _start là value giây ban đầu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer test"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  // reference to file count_down_page_2.dart
                  context,
                  MaterialPageRoute(builder: (context) => const CountDownCustomCubitPage(seconds: 100)));
            },
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<int>(
                  initialData: _start,
                  stream: _timeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final int time = snapshot.data!;
                      // separateWidget - definition dấu ":" separate hour:minut:second để chèn bên dưới
                      var separateWidget = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          ':',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: 'BlackOpsOne',
                              ),
                          textAlign: TextAlign.center,
                        ),
                      );
                      return FittedBox(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                number: time.hour.tens,
                              ),
                              TextWidget(
                                number: time.hour.ones,
                              ),
                              separateWidget,
                              TextWidget(
                                number: time.minute.tens,
                              ),
                              TextWidget(
                                number: time.minute.ones,
                              ),
                              separateWidget,
                              TextWidget(
                                number: time.second.tens,
                              ),
                              TextWidget(
                                number: time.second.ones,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
              StreamBuilder(
                initialData: CountDownEvent.reset,
                stream: _functionController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    if (data == CountDownEvent.reset) {
                      return Button(
                        onTap: () {
                          _functionController.add(CountDownEvent.start);
                        },
                        title: "Start",
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          onTap: data == CountDownEvent.pause
                              ? () {} // ko làm gì khi CountDownEvent = pause
                              : () {
                                  _functionController.add(CountDownEvent.pause);
                                },
                          title: 'Pause',
                          isActive:
                              data != CountDownEvent.pause, // set Trạng thái nút - nếu đang pause thì isActive = false
                        ),
                        Button(
                          onTap: data == CountDownEvent.resume
                              ? () {}
                              : () {
                                  _functionController.add(CountDownEvent.resume);
                                },
                          title: 'Resume',
                          isActive: data != CountDownEvent.resume, // Trạng thái nút
                        ),
                        Button(
                          onTap: () {
                            _functionController.add(CountDownEvent.reset);
                          },
                          title: 'Reset',
                          isActive: true, // Nút Reset luôn hoạt động
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// áp dụng trong StreamBuilder<int>(
class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final size = textSize(
      '0',
      Theme.of(context).textTheme.headlineLarge!.copyWith(fontFamily: 'BlackOpsOne'),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: size.width,
        child: Center(
          child: Text(
            number.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: 'BlackOpsOne'),
          ),
        ),
      ),
    );
  }
}

Size textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 2,
    textDirection: TextDirection.ltr,
  )..layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
  return textPainter.size;
}

enum CountDownEvent {
  start,
  pause,
  resume,
  reset,
}

///seconds => separate time
extension IntToTime on int {
  ///lấy thông tin giờ
  int get hour => _getHour();

  int _getHour() {
    return (this / 3600).floor();
    // return Duration(seconds: this).inHours;
  }

  ///lấy thông tin giờ
  int get minute => _getMinute();

  int _getMinute() {
    return (this / 60).floor() % 60;
  }

  ///lấy thông tin giây
  int get second => _getSecond();

  int _getSecond() {
    return this % 60;
  }

  ///format hiển thị số ở hàng chục
  int get tens => _getTens();

  int _getTens() {
    if (this >= 10) {
      return ((this - (this % 10)) / 10).round();
    }
    return 0;
  }

  ///format hiển thị số ở hàng đơn vị
  int get ones => _getOnes();

  int _getOnes() {
    return this % 10;
  }
}

// áp dụng trong  StreamBuilder<CountDownEvent>(

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = true, // Mặc định là active
  });

  final String title;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? onTap : () {}, // Giữ onTap nhưng không làm gì khi không hoạt động
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.transparent : const Color.fromARGB(255, 195, 178, 178), // Đổi màu khi không active
          border: Border.fromBorderSide(
            BorderSide(
              width: 1,
              color: isActive ? Colors.black45 : Colors.grey, // Màu viền cũng đổi
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'BlackOpsOne',
                color: isActive ? Colors.black : Colors.grey, // Đổi màu chữ khi không active
              ),
        ),
      ),
    );
  }
}
