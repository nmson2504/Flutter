import 'package:flutter/material.dart';

// context.widget - tên widget hiện tại
// context.runtimeType - kiểu runtime của widget hiện tại (StatelessWidget or StatefulWidget)
// context.describeElement('Description') - trả về một chuỗi mô tả của widget hiện tại (là chuỗi truyền vào phương thức describeElement)
// context.findAncestorWidgetOfExactType<Center>()) - trả về widget cha gần nhất (widget chứa context)có kiểu là Center (và có thể cùng với các thuộc tính của nó)
// print(context.widget);
// print(context.runtimeType);
// print(context.describeElement('Description'));
// print(context.findRootAncestorStateOfType Function() Function );
class MyContext extends StatelessWidget {
  const MyContext({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter BuildContext Demo'),
          ),
          body: Center(child: Builder(builder: (context) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Text 1',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Text('Text 2', style: TextStyle(fontSize: 40)),
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Hahahaha'),
                        ));
                      },
                      child: const Text('SHOW SNACKBAR')),
                  FloatingActionButton(onPressed: () {
                    Scaffold.of(context).showBottomSheet((context) => Text(
                        'Flutter From Zero to Hero',
                        style: Theme.of(context).textTheme.titleLarge));
                  })
                ]);
          }))),
    );
  }
}

// demo context OngBa - ChaMe - Con1 - Con2
class MyContext1 extends StatelessWidget {
  const MyContext1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme: const TextTheme(
                titleLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green))),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter BuildContext Demo'),
            ),
            body: const Center(
              child: OngBa(
                  child: ChaMe(
                      child: Column(
                children: [Con1(), Con2()],
              ))),
            )));
  }
}

class OngBa extends StatelessWidget {
  final Widget child;
  const OngBa({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }

  static OngBa? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType();
  }

  getOngBa() {
    return 'getOngBa';
  }
}

class ChaMe extends StatelessWidget {
  final Widget child;
  const ChaMe({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }

  static ChaMe? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType();
  }

  getChaMe() {
    return 'getChaMe';
  }
}

class Con1 extends StatelessWidget {
  const Con1({super.key});

  @override
  Widget build(BuildContext context) {
    OngBa ofOngBa = OngBa.of(context) as OngBa;
    String ch = ofOngBa.getOngBa();

    return Text('Is Con 1 - $ch',
        style: Theme.of(context).textTheme.titleLarge);
  }
}

class Con2 extends StatelessWidget {
  const Con2({super.key});

  @override
  Widget build(BuildContext context) {
    ChaMe ofChaMe = ChaMe.of(context) as ChaMe;
    String ch = ofChaMe.getChaMe();
    return Text('Is Con 2 - $ch',
        style: Theme.of(context).textTheme.titleLarge);
  }
}
