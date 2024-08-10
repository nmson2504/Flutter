import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFractionallySizedBox extends StatelessWidget {
  const MyFractionallySizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FractionallySizedBoxDemo2(),
      // backgroundColor: Color.fromARGB(255, 235, 217, 163),
    );
  }
}

//---------------------------
// alignment = Alignment.center - default
class FractionallySizedBoxDemo1 extends StatelessWidget {
  const FractionallySizedBoxDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter FractionallySizedBox 1')),
      body: SizedBox.expand(
          child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        alignment: FractionalOffset.center,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
          ),
        ),
      )),
    );
  }
}

// alignment = Alignment.center - default
// alignment: Alignment.bottomCenter, alignment: Alignment.bottomCenter,
class FractionallySizedBoxDemo2 extends StatelessWidget {
  const FractionallySizedBoxDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FractionallySizedBox Demo 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu sắc của viền
                  width: 2.0, // Độ dày của viền
                ),
              ),
              child: SizedBox(
                child: FractionallySizedBox(
                  widthFactor: 0.5, // Chiếm 50% chiều rộng của không gian cha
                  heightFactor: 0.5, // Chiếm 50% chiều cao của không gian cha
                  child: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '50% Width & Height',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu sắc của viền
                  width: 2.0, // Độ dày của viền
                ),
              ),
              child: SizedBox(
                child: FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  widthFactor: 0.5, // Chiếm 50% chiều rộng của không gian cha
                  heightFactor: 0.5, // Chiếm 50% chiều cao của không gian cha
                  child: Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '50% Width & Height',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red, // Màu sắc của viền
                  width: 3.0, // Độ dày của viền
                ),
              ),
              child: SizedBox(
                child: FractionallySizedBox(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.8, // Chiếm 80% chiều rộng của không gian cha
                  heightFactor: 0.3, // Chiếm 30% chiều cao của không gian cha
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        '80% Width & 30% Height',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
