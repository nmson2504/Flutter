import 'dart:async';
import 'package:flutter/material.dart';

import 'count_down_page/count_down_page.dart';

class MyDemoStreamBuilder extends StatelessWidget {
  const MyDemoStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const Counter01(),
      2: () => const Counter02(),
      3: () => const StreamBuilderExampleApp(),
      4: () => const Example4(),
    };
    int n = 3; // Giá trị n có thể thay đổi
    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      home: bodyWidget, // Truyền Widget vào body
    );
  }
}
/* Lưu ý
Stream không yêu cầu async/await: Khi làm việc với Stream, bạn phát ra dữ liệu mà không cần phải chờ. Điều này cho phép bạn tiếp tục xử lý các tác vụ khác trong ứng dụng của bạn trong khi vẫn nhận dữ liệu từ Stream.

Sử dụng async/await cho các thao tác bất đồng bộ khác: Bạn sẽ sử dụng async/await cho các thao tác mà bạn cần chờ kết quả trước khi thực hiện các bước tiếp theo.
 */
// Example 1 - counter
/* sử dụng StreamBuilder để theo dõi dữ liệu từ một Stream và cập nhật giao diện người dùng mỗi khi dữ liệu trong Stream thay đổi. Trong trường hợp này, chúng ta sử dụng một StreamController để tạo một Stream và gửi dữ liệu mới vào Stream mỗi giây. */
/*
Timer.periodic là một phương thức trong Dart dùng để tạo ra một bộ đếm thời gian (timer) chạy theo chu kỳ.
Nó nhận vào hai tham số:
Duration: Tham số đầu tiên xác định khoảng thời gian giữa các lần gọi lại. Ở đây, const Duration(seconds: 1) có nghĩa là timer sẽ chạy mỗi giây một lần.
Callback Function: Tham số thứ hai là một hàm gọi lại (callback) sẽ được thực thi mỗi khi timer hết thời gian. Hàm này nhận vào một tham số timer, đại diện cho đối tượng timer.
(timer) { ... }:
Đây là hàm gọi lại mà sẽ được gọi mỗi giây. Tham số timer chứa thông tin về timer hiện tại.
_streamController.sink.add(timer.tick);:

_streamController là một đối tượng StreamController, dùng để quản lý và phát các sự kiện đến một luồng (stream).
sink là một thuộc tính của StreamController, cho phép bạn thêm dữ liệu vào luồng.
add(timer.tick):
timer.tick trả về số giây đã trôi qua kể từ khi timer bắt đầu. Giá trị này sẽ được gửi vào sink của _streamController, giúp các listener đăng ký trên stream nhận được giá trị này.
Mỗi lần hàm gọi lại được thực thi, nó sẽ thêm số giây hiện tại vào luồng. */

class Counter01 extends StatefulWidget {
  const Counter01({super.key});

  @override
  _Counter01State createState() => _Counter01State();
}

class _Counter01State extends State<Counter01> {
  final StreamController<int> _streamController = StreamController<int>();
  Timer? _timer; // Để lưu trữ timer

  @override
  void initState() {
    super.initState();
    // Thêm dữ liệu vào Stream mỗi giây
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.sink.add(timer.tick);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy Timer khi không cần nữa
    _streamController.close(); // Đóng Stream khi không cần nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder Counter01'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          // Stream chứa các giá trị kiểu int.
          stream: _streamController.stream, // Lắng nghe dữ liệu từ StreamController
          initialData: 0,
          builder: (context, snapshot) {
            // Xây dựng giao diện người dùng (UI)
            // snapshot chứa dữ liệu mới nhất từ Stream.
            return Text(
              'Count: ${snapshot.data}',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
// Example 2 - counter có check trạng thái của snapshot: Đây là đối tượng chứa giá trị và trạng thái hiện tại của stream.

class Counter02 extends StatelessWidget {
  const Counter02({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Tạo ra một StreamController
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;
  Timer? _timer;

  // Hàm này để phát số đếm vào stream mỗi 1 giây
  void _startCounterStream() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counter++;
      _streamController.sink.add(_counter); // Gửi giá trị vào stream
    });
  }

  @override
  void initState() {
    super.initState();
    _startCounterStream(); // Bắt đầu stream khi khởi tạo màn hình
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hủy Timer khi không cần nữa
    _streamController.close(); // Đóng Stream khi không cần nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder Counter02'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _streamController.stream, // Lắng nghe stream này
          builder: (context, snapshot) {
            // kiểm tra trên trạng thái của snapshot
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Khi Stream chưa phát ra giá trị nào
              return const Text('Waiting for data...');
            } else if (snapshot.hasError) {
              // Nếu có lỗi xảy ra
              return const Text('Error occurred');
            } else if (snapshot.hasData) {
              // Khi có dữ liệu từ stream
              return Text(
                'Counter: ${snapshot.data}', // Hiển thị dữ liệu
                style: const TextStyle(fontSize: 24),
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
/* snapshot: Đây là đối tượng chứa giá trị và trạng thái hiện tại của stream. Chúng ta sử dụng snapshot.data để lấy giá trị được phát ra từ stream.
Các trạng thái của snapshot:
ConnectionState.waiting: Stream chưa phát ra dữ liệu.
snapshot.hasData: Stream đã có dữ liệu.
snapshot.hasError: Stream có lỗi xảy ra. */

//* / Example 3 -
class StreamBuilderExampleApp extends StatelessWidget {
  const StreamBuilderExampleApp({super.key});

  static const Duration delay = Duration(seconds: 1); // thời gian chờ

  @override
  Widget build(BuildContext context) {
    return const StreamBuilderExample(delay: delay);
  }
}

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({
    required this.delay,
    super.key,
  });

  final Duration delay;

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  /* 
  Định nghĩa của StreamController như dưới đây được gọi là "lazy initialized stream controller with onListen callback" (StreamController khởi tạo trễ với callback onListen). Cách này có một số đặc điểm quan trọng:
    Callback onListen: Đây là một chức năng đặc biệt của StreamController. Nó được gọi tự động khi một listener đăng ký (listen) vào stream lần đầu. Điều này giúp thực hiện một số thao tác chuẩn bị hoặc logic bổ sung khi bắt đầu lắng nghe. 
    Cụ thể ở đây:
    Khi một listener đầu tiên đăng ký vào _controller.stream, onListen sẽ:
    - Chờ một khoảng thời gian (theo widget.delay).
    - Phát giá trị 100 vào stream nếu _controller chưa bị đóng.
    - Chờ thêm một khoảng thời gian và sau đó đóng _controller.
    */
  late final StreamController<int> _controller = StreamController<int>(
    onListen: () async {
      // onListen: Đây là một callback được gọi khi có người đăng ký (subscribe) để lắng nghe stream.
      await Future<void>.delayed(widget.delay);

      if (!_controller.isClosed) {
        _controller.add(100); // đưa value vào stream
      }

      await Future<void>.delayed(widget.delay);

      if (!_controller.isClosed) {
        _controller.close();
      }
    },
  );
// getter trong _StreamBuilderExampleState class, trả về một Stream<int> từ _controller.stream.
  Stream<int> get _bids => _controller.stream;

  @override
  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: const Color.fromARGB(255, 241, 184, 157),
        child: BidsStatus(bids: _bids), // truyền stream _bids đinh nghĩa ở trên
      ),
    );
  }
}

class BidsStatus extends StatelessWidget {
  const BidsStatus({
    required this.bids,
    super.key,
  });

  final Stream<int>? bids;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: bids,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        // List<Widget> children được sử dụng để lưu trữ danh sách các Widget hiển thị theo từng trạng thái khác nhau của Stream. Những widget này sẽ hiển thị nội dung phù hợp với từng trạng thái của Stream được truyền vào thông qua AsyncSnapshot<int> snapshot.
        List<Widget> children;
        // Kiểm tra trạng thái snapshot.hasError, nếu ko có thì vào switch (snapshot.connectionState)
        if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Stack trace: ${snapshot.stackTrace}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ];
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              children = const <Widget>[
                Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Select a lot'),
                ),
              ];
            case ConnectionState.waiting:
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting bids...'),
                ),
              ];
            case ConnectionState.active:
              children = <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Active - \$${snapshot.data}'),
                ),
              ];
            case ConnectionState.done:
              children = <Widget>[
                const Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    snapshot.hasData ? 'Done - \$${snapshot.data}' : 'Done',
                  ),
                ),
              ];
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children, // gán List<Widget> children cho UI sau khi đã get data với swith-case ở trên
        );
      },
    );
  }
}
/* 
+ StreamBuilderExampleApp - Widget chính của ứng dụng
  Đây là widget gốc của ứng dụng. Nó khởi tạo một instance của StreamBuilderExample với một độ trễ (delay) là 1 giây, được truyền vào thông qua thuộc tính delay.
  Mục đích: Để khởi động ứng dụng và truyền delay cho StreamBuilderExample.

+ StreamBuilderExample - Widget quản lý Stream
  StreamBuilderExample là một StatefulWidget, nghĩa là nó có trạng thái thay đổi theo thời gian.
  Mục đích: Tạo ra một stream và phát giá trị vào stream sau một khoảng thời gian trễ (1 giây), sau đó đóng stream.

+ Lớp _StreamBuilderExampleState - Xử lý logic của stream
  StreamController<int>: Đối tượng này quản lý stream và phát các giá trị vào stream.
  onListen: Callback này được thực hiện khi có listener đăng ký lắng nghe stream. Sau mỗi khoảng thời gian trễ (widget.delay), giá trị 1 được phát vào stream và sau đó stream sẽ được đóng.
  dispose(): Được gọi khi widget bị hủy, đảm bảo rằng stream được đóng để tránh rò rỉ tài nguyên.
  build(): Trả về UI của widget, sử dụng BidsStatus để hiển thị dữ liệu từ stream.

+ BidsStatus - Widget hiển thị trạng thái của dữ liệu từ stream
  StreamBuilder: Lắng nghe stream và xây dựng UI dựa trên trạng thái và dữ liệu của stream. Các trạng thái bao gồm:
  ConnectionState.none: Chưa có stream hoặc không có dữ liệu để lắng nghe.
  ConnectionState.waiting: Đang chờ dữ liệu từ stream, hiển thị một CircularProgressIndicator để thông báo cho người dùng rằng dữ liệu đang chờ.
  ConnectionState.active: Stream đã phát ra dữ liệu và UI hiển thị giá trị nhận được.
  ConnectionState.done: Stream đã đóng, hiển thị thông báo rằng stream đã kết thúc.

Các trạng thái của snapshot được kiểm tra bằng snapshot.connectionState, và đoạn code này xử lý các trường hợp khác nhau dựa trên trạng thái:
snapshot.hasError:
Mục đích: Kiểm tra xem Stream có gặp lỗi hay không.
Hành động:
Nếu có lỗi, UI sẽ hiển thị một biểu tượng lỗi (Icons.error_outline màu đỏ).
Sau đó, nó hiển thị thông báo về lỗi và chuỗi stack trace (gọi là snapshot.error và snapshot.stackTrace).
Mô tả: Đây là trường hợp xử lý lỗi khi Stream phát ra lỗi, giúp người dùng biết rằng có sự cố xảy ra.
snapshot.connectionState:

ConnectionState.none:
Mục đích: Kiểm tra xem Stream không có kết nối (không ai lắng nghe hoặc Stream chưa bắt đầu).
Hành động: Hiển thị biểu tượng thông tin (Icons.info màu xanh) và thông báo "Select a lot" để chỉ ra rằng không có dữ liệu nào được phát ra từ Stream và cần có thao tác từ người dùng.
ConnectionState.waiting:
Mục đích: Kiểm tra xem Stream đang chờ dữ liệu, nhưng chưa phát ra giá trị nào.
Hành động: Hiển thị một biểu tượng CircularProgressIndicator (vòng tròn tải) để báo cho người dùng biết rằng hệ thống đang đợi dữ liệu, kèm theo thông báo "Awaiting bids...".
Mô tả: Đây là trạng thái phổ biến khi Stream bắt đầu nhưng chưa có dữ liệu, và người dùng cần đợi.
ConnectionState.active:
Mục đích: Kiểm tra xem Stream đang hoạt động và phát ra dữ liệu mới nhất.
Hành động: Hiển thị biểu tượng check (Icons.check_circle_outline màu xanh lá) và dữ liệu giá trị hiện tại từ Stream (ví dụ: \$1).
Mô tả: Khi Stream phát ra dữ liệu và người dùng lắng nghe được, UI sẽ cập nhật với giá trị mới từ snapshot.data.
ConnectionState.done:
Mục đích: Kiểm tra xem Stream đã hoàn thành (đã đóng).
Hành động: Hiển thị biểu tượng thông tin (Icons.info màu xanh) và thông báo rằng Stream đã kết thúc, kèm theo giá trị cuối cùng (nếu có) hoặc hiển thị (Done) nếu không có dữ liệu.
Mô tả: Đây là trạng thái cuối cùng khi Stream không còn phát ra dữ liệu nữa và đã kết thúc.
Diễn giải logic kiểm tra trạng thái:
Đầu tiên, code kiểm tra xem có lỗi hay không bằng snapshot.hasError. Nếu có lỗi, nó hiển thị thông tin lỗi ngay lập tức.
Nếu không có lỗi, code sử dụng switch để kiểm tra trạng thái của snapshot.connectionState:
Nếu là none, thông báo rằng không có gì để hiển thị.
Nếu là waiting, hiển thị vòng tròn tải để cho biết dữ liệu đang đến.
Nếu là active, hiển thị giá trị dữ liệu hiện tại từ Stream.
Nếu là done, thông báo rằng Stream đã đóng, và hiển thị giá trị cuối cùng hoặc (closed) nếu không có dữ liệu.
Tóm lại, logic kiểm tra giúp UI phản ứng theo các trạng thái của Stream, đảm bảo rằng người dùng luôn biết tình trạng của luồng dữ liệu đang lắng nghe.
 */

// Example 4
class Example4 extends StatelessWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleBoardPage();
  }
}

class ExampleBoardPage extends StatefulWidget {
  const ExampleBoardPage({super.key});

  @override
  _ExampleBoardPageState createState() => _ExampleBoardPageState();
}

class _ExampleBoardPageState extends State<ExampleBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Board',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
              onPressed: () {
                push(
                  // call function push with CountDownPage
                  context,
                  const CountDownPage(seconds: 100), // reference to file count_down_page.dart
                );
              },
              child: const Text('Count Down'))
        ],
      ),
    );
  }
}

// function navigator route
Future push(BuildContext context, Widget child) async {
  return await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return child;
      },
    ),
  );
}
