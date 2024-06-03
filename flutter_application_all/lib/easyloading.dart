import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './custom_animation.dart';
import './test.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration =
        const Duration(milliseconds: 2000) //tgian display hiệu ứng
    ..indicatorType =
        EasyLoadingIndicatorType.ring // set dedault EasyLoadingIndicatorType
    ..loadingStyle =
        EasyLoadingStyle.dark // set dedault EasyLoadingIndicatorType
    ..indicatorSize = 40.0 // size off Indicator
    ..radius = 10.0 // bo góc
    ..progressColor = Colors.blueGrey // with .showProgress
    ..backgroundColor = Colors.yellow // background của all hiệu ứng
    ..indicatorColor =
        Color.fromARGB(255, 86, 20, 241) // indicator - hình ảnh trong hiệu ứng
    ..textColor = Color.fromARGB(255, 248, 19, 191) // text in hiệu ứng
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true // cho phép tương tác các button
    ..dismissOnTap = false // cho phép sử dụng phím tab
    ..customAnimation = CustomAnimation(); // set customAnimation
}

class MyEasyLoading extends StatelessWidget {
  const MyEasyLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const EasyLoading4(),
      builder: EasyLoading.init(),
    );
  }
}

class EasyLoading1 extends StatelessWidget {
  const EasyLoading1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Flutter EasyLoading Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            EasyLoading.showProgress(0.3, status: 'downloading...');
            Future.delayed(const Duration(seconds: 2), () {
              EasyLoading.dismiss();
            });
          },
          child: const Text('Show Loading'),
        ),
      ),
    );
  }
}

//--------------------------

class EasyLoading2 extends StatelessWidget {
  const EasyLoading2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show the progress indicator with 30% progress and a status message
            EasyLoading.showProgress(0.3, status: 'downloading...');

            // Simulate a delay to update the progress
            Future.delayed(const Duration(seconds: 2), () {
              // Dismiss the progress indicator after 2 seconds
              EasyLoading.dismiss();
            });
          },
          child: const Text('Start Download'),
        ),
      ),
    );
  }
}

// ----------------------------

class EasyLoading3 extends StatelessWidget {
  const EasyLoading3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter EasyLoading3 Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            EasyLoading.showProgress(0.2, status: 'downloading.1..');
            Future.delayed(const Duration(seconds: 2), () {
              EasyLoading.showProgress(0.2, status: 'downloading.2..');
            });
            Future.delayed(const Duration(seconds: 4), () {
              EasyLoading.showProgress(0.4, status: 'downloading.2..');
            });
            Future.delayed(const Duration(seconds: 6), () {
              EasyLoading.showProgress(0.8, status: 'downloading.3..');
            });
            Future.delayed(const Duration(seconds: 8), () {
              EasyLoading.showProgress(1.0, status: 'Complete');
              EasyLoading.dismiss();
            });
          },
          child: const Text('Show Loading'),
        ),
      ),
    );
  }
}

// ---------------------------
/* 
Các method của EasyLoading
Ngoài 2 method show và showProgress phải gọi  EasyLoading.dismiss() để kết thúc tiến trình thì các method khác auto dismiss
 */

class EasyLoading4 extends StatelessWidget {
  const EasyLoading4({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Flutter EasyLoading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'All Flutter EasyLoading') tuong duong
      // AppBar(title: const Text('All Flutter EasyLoading'),
      home: MyHomePage(title: 'All Flutter EasyLoading'),
      // load EasyLoading
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  late double _progress;
  num a = 0;
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      a++;
      print('$a - EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // show khi giao diện mới load lần đầu
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const TextField(),
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text('open test page'),
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TestPage(),
                        ),
                      );
                    },
                  ),
                  // EasyLoading.dismiss - stop method EasyLoading.show
                  TextButton(
                    child: const Text('dismiss'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.dismiss();
                      print('EasyLoading dismiss');
                    },
                  ),
                  // EasyLoading.show chỉ stop khi gọi EasyLoading.dismiss
                  // nếu set await Future.delayed(const Duration(seconds: 2)) và gọi .dismiss thì sẽ chạy hết tgian delayed rồi mới stop
                  TextButton(
                    child: const Text('show'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      print('EasyLoading show');
                      // await Future.delayed(const Duration(seconds: 2));

                      // Dismiss the loading indicator
                      // EasyLoading.dismiss();
                    },
                  ),
                  TextButton(
                    child: const Text('showToast'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showToast(
                        'Toast',
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('showSuccess'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.showSuccess('Great Success!');
                      print('EasyLoading showSuccess');
                    },
                  ),
                  TextButton(
                    child: const Text('showError'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showError('Failed with Error');
                    },
                  ),
                  TextButton(
                    child: const Text('showInfo'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showInfo('Useful Information.');
                    },
                  ),
                  TextButton(
                    child: const Text('showProgress'),
                    onPressed: () {
                      _progress = 0;
                      _timer?.cancel();
                      _timer = Timer.periodic(const Duration(milliseconds: 100),
                          (Timer timer) {
                        EasyLoading.showProgress(_progress,
                            status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress +=
                            0.05; // _progress += 0.05 - số % mỗi bước dịch chuyển

                        if (_progress >= 1) {
                          _timer?.cancel();
                          EasyLoading.dismiss();
                        }
                      });
                    },
                  ),
                ],
              ),
              // Set EasyLoadingStyle - dark, light, custom
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Style - EasyLoadingStyle'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingStyle>(
                        selectedColor: Colors.blue,
                        children: const {
                          EasyLoadingStyle.dark: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('dark'),
                          ),
                          EasyLoadingStyle.light: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('light'),
                          ),
                          EasyLoadingStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.loadingStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Set EasyLoadingMaskType - type nền màn hình khi kích hoạt EasyLoading
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('MaskType - EasyLoadingMaskType'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingMaskType>(
                        selectedColor: Colors.blue,
                        children: const {
                          EasyLoadingMaskType.none: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('none'),
                          ),
                          EasyLoadingMaskType.clear: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('clear'),
                          ),
                          EasyLoadingMaskType.black: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('black'),
                          ),
                          EasyLoadingMaskType.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.maskType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Set Toast position
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Toast Position - EasyLoadingToastPosition'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingToastPosition>(
                        selectedColor: Colors.blue,
                        children: const {
                          EasyLoadingToastPosition.top: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('top'),
                          ),
                          EasyLoadingToastPosition.center: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('center'),
                          ),
                          EasyLoadingToastPosition.bottom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('bottom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.toastPosition = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // set EasyLoadingAnimationStyle
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Animation Style - EasyLoadingAnimationStyle'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingAnimationStyle>(
                        selectedColor: Colors.blue,
                        children: const {
                          EasyLoadingAnimationStyle.opacity: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('opacity'),
                          ),
                          EasyLoadingAnimationStyle.offset: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('offset'),
                          ),
                          EasyLoadingAnimationStyle.scale: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('scale'),
                          ),
                          EasyLoadingAnimationStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.animationStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // set EasyLoadingIndicatorType - kích hoạt với method EasyLoading.show
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 50.0,
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                        'IndicatorType - EasyLoadingIndicatorType(total: 23)'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingIndicatorType>(
                        selectedColor: Colors.blue,
                        children: const {
                          EasyLoadingIndicatorType.circle: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('circle'),
                          ),
                          EasyLoadingIndicatorType.wave: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('wave'),
                          ),
                          EasyLoadingIndicatorType.ring: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('ring'),
                          ),
                          EasyLoadingIndicatorType.pulse: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('pulse'),
                          ),
                          EasyLoadingIndicatorType.cubeGrid: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('cubeGrid'),
                          ),
                          EasyLoadingIndicatorType.threeBounce: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('threeBounce'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.indicatorType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
