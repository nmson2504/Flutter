import 'package:flutter/material.dart';

class MySafeArea extends StatelessWidget {
  const MySafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      home: SafeArea6(), // Để call Home6A ưidget required đặt Scaffold tại đây
    );
  }
}

// SafeArea1 - not SafeArea
class SafeArea1 extends StatelessWidget {
  const SafeArea1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ko set AppBar để thấy Container tràn lên trên
      // appBar: AppBar(title: const Text("SafeArea1 - not SafeArea"), backgroundColor: Colors.blueGrey,),

      // Container là root nên sẽ bung full screen
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'SafeArea 1 - not SafeArea',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// SafeArea2 - with SafeArea
class SafeArea2 extends StatelessWidget {
  const SafeArea2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SafeArea2 - not SafeArea with AppBar"),
          backgroundColor: Colors.blueGrey,
        ),

        // Container là root nên sẽ bung full screen
        body: Container(
          color: Colors.amber,
          child: Center(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'SafeArea 2 - not SafeArea with AppBar',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// SafeArea1a - not SafeArea with Column
class SafeArea1a extends StatelessWidget {
  const SafeArea1a({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SafeArea1a - not SafeArea with root Container"),
        backgroundColor: Colors.blueGrey,
      ),
      // Container là root nên sẽ bung full screen
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'SafeArea 1a - not SafeArea',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'SafeArea 1a - not SafeArea',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// SafeArea1b - not SafeArea with Column
class SafeArea1b extends StatelessWidget {
  const SafeArea1b({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SafeArea1b - with SafeArea with root Container"),
        backgroundColor: Colors.blueGrey,
      ),

      // Container là root nên sẽ bung full screen
      body: SafeArea(
        child: Container(
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(5.0),
                child: const Text(
                  'SafeArea 1b -  SafeArea',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(5.0),
                child: const Text(
                  'SafeArea 1b -  SafeArea',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// SafeArea3 - not SafeArea
class SafeArea3 extends StatelessWidget {
  const SafeArea3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SafeArea3 - not SafeArea"),
          backgroundColor: const Color.fromARGB(255, 127, 129, 4),
        ),
        body: Container(
          color: Colors.amber,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: 100,
                child: const Center(child: Text('Top Safe Area')),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: const Center(child: Text('Main Content')),
                ),
              ),
              SafeArea(
                child: Container(
                  color: Colors.red,
                  height: 100,
                  child: const Center(child: Text('Bottom Safe Area')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  SafeArea4 - with SafeArea
class SafeArea4 extends StatelessWidget {
  const SafeArea4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SafeArea4 - with SafeArea"),
          backgroundColor: const Color.fromARGB(255, 127, 129, 4),
        ),
        body: Container(
          color: Colors.amber,
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  color: Colors.blue,
                  height: 100,
                  child: const Center(child: Text('Top Safe Area')),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: const Center(child: Text('Main Content')),
                ),
              ),
              SafeArea(
                child: Container(
                  color: Colors.red,
                  height: 100,
                  child: const Center(child: Text('Bottom Safe Area')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  SafeArea5 - ResponsiveLayout
// Kết hợp với MediaQuery để điều chỉnh layout:

class SafeArea5 extends StatelessWidget {
  const SafeArea5({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: screenHeight * 0.2,
              width: screenWidth,
              child: const Center(child: Text('Top Safe Area')),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: const Center(child: Text('Main Content')),
              ),
            ),
            Container(
              color: Colors.red,
              height: screenHeight * 0.1,
              width: screenWidth,
              child: const Center(child: Text('Bottom Safe Area')),
            ),
          ],
        ),
      ),
    );
  }
}

//  SafeArea6 - Responsive với Orientation (hướng màn hình): Điều chỉnh layout dựa trên hướng màn hình.
class SafeArea6 extends StatelessWidget {
  const SafeArea6({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("SafeArea6"),
          ),
          body: SafeArea(
            child: orientation == Orientation.portrait
                ? Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 100,
                        child: const Center(child: Text('Top Safe Area')),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: const Center(
                              child: Text('Main Content In Column')),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        height: 100,
                        child: const Center(child: Text('Bottom Safe Area')),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        color: Colors.blue,
                        width: 100,
                        child: const Center(child: Text('Left Safe Area')),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child:
                              const Center(child: Text('Main Content In Row')),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        width: 100,
                        child: const Center(child: Text('Right Safe Area')),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
