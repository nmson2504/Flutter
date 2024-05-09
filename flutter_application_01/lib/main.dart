import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_01/drawer.dart';
import 'package:flutter_application_01/gesture.dart';
import 'navigation.dart';
import 'package:flutter_application_01/dismissible.dart';
import 'linearprogress.dart';
import 'circularprogress.dart';

void main() {
  debugPrintGestureArenaDiagnostics = true;
  // changes app in this
  // runApp(const MyMenuAnchor());
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight
  // ]);
  runApp(const MyCircularProgress());
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
