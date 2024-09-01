import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_01/card.dart';
import 'package:flutter_application_01/easyloading.dart';
// import 'circularprogress.dart';
import 'listview.dart';
import 'gridview.dart';
import 'refreshindicator.dart';
import 'refreshindicator-1.dart';
import 'refreshindicator-2.dart';
import 'pull_to_refresh.dart';
import 'pageview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'stack.dart';
import 'stack2.dart';
import 'demoUI1.dart';
import 'decoratedbox.dart';
import 'demoUI2.dart';
import 'safearea.dart';
import 'mediaquery.dart';
import 'fractionallysizedbox.dart';
import 'box_vien_background.dart';
import 'custom_paint.dart';
import 'custom_paint2.dart';
import 'textfield.dart';
import 'container.dart';
import 'container2.dart';
import 'padding.dart';
import 'bottomappbar.dart';
import 'singlechildscrollview.dart';
import 'scrollbar.dart';
import 'gesture.dart';
import 'dismissible.dart';
import 'valuelistenablebuilder.dart';
import 'const_constructor.dart';

void main() {
  // debugPrintGestureArenaDiagnostics = true;
  // changes app in this
  // runApp(const MyMenuAnchor());
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  // DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight
  // ]);
  runApp(const MyConst());
  configLoading();
  // runApp(MaterialApp(home: MyAppImpl())); // if class định nghĩa ko có MaterialApp
}


/* import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
} */

/* class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 100,
              itemBuilder: (context, item) {
                return SizedBox(
                  width: 100,
                  child: Card(
                    child: Center(
                      child: Text("$item"),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
} */
