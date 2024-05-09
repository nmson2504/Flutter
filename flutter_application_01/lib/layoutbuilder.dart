import 'package:flutter/material.dart';

class MyLayoutBuilder extends StatelessWidget {
  const MyLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter LayoutBuilder')),
        body: const LayoutBuilder02(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//---------------------------

class LayoutBuilder01 extends StatelessWidget {
  const LayoutBuilder01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder01 Example')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildNormalContainer() {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
        child: const Text('Normal Container - constraints.maxWidth <= 600'),
      ),
    );
  }

  Widget _buildWideContainers() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Text('Wide Containers - constraints.maxWidth > 600'),
          Container(
            height: 100.0,
            width: 100.0,
            color: Colors.red,
          ),
          Container(
            height: 100.0,
            width: 100.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}

// Demo using MediaQuery &

class LayoutBuilder02 extends StatefulWidget {
  const LayoutBuilder02({super.key});

  @override
  State<LayoutBuilder02> createState() => _LayoutBuilder02State();
}

class _LayoutBuilder02State extends State<LayoutBuilder02> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LayoutBuilder02 Demo'),
          centerTitle: true,
        ),
        body: Container(
          /// Giving dimensions to parent Container
          /// using MediaQuery
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,

          child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
              // if the screen width >= 480 i.e Wide Screen
              if (constraints.maxWidth >= 480) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      height: constraints.maxHeight * 0.3,
                      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        'Left Wide Screen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      height: constraints.maxHeight * 0.3,
                      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        'Right Wide Screen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );

                // If screen size is < 480
              } else {
                return Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight * 0.3,
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    'Normal Screen',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// LayoutBuilder03 - constraints.maxHeight/maxWidth
class LayoutBuilder03 extends StatelessWidget {
  const LayoutBuilder03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      // Large screens (tablet on landscape mode, desktop, TV)
      if (constraints.maxWidth > 600) {
        return Row(
          children: [
            Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.2,
                  width: constraints.maxWidth * 0.75,
                  color: Colors.blueAccent,
                  child: const Center(
                    child: Text('Header'),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: constraints.maxWidth * 0.75,
                  color: Colors.amber,
                  child: const Center(
                    child: Text('Main Content'),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  width: constraints.maxWidth * 0.75,
                  color: Colors.lightGreen,
                  child: const Center(
                    child: Text('Footer'),
                  ),
                ),
              ],
            ),
            Container(
              width: constraints.maxWidth * 0.25,
              height: constraints.maxHeight,
              color: Colors.pink,
              child: const Center(
                child: Text('Right Sidebar'),
              ),
            ),
          ],
        );
      }

      // Samll screens
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.2,
            color: Colors.blue,
            child: const Center(
              child: Text('Header'),
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            color: Colors.amber,
            child: const Center(
              child: Text('Main Content'),
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.2,
            color: Colors.lightGreen,
            child: const Center(
              child: Text('Footer'),
            ),
          )
        ],
      );
    }));
  }
}
