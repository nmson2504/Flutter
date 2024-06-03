import 'package:flutter/material.dart';

class MyListener extends StatelessWidget {
  const MyListener({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Listener')),
        body: const Listener01A(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//----------------------------------------------------------------
class Listener01 extends StatefulWidget {
  const Listener01({super.key});

  @override
  State<Listener01> createState() => _Listener01State();
}

class _Listener01State extends State<Listener01> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: _incrementDown,
        onPointerMove: _updateLocation,
        onPointerUp: _incrementUp,
        child: Container(
          width: 400,
          height: 400,
          color: Colors.blue,
          child: ColoredBox(
            color: Colors.yellowAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Tap, drag, or move your pointer here!'),
                Text(
                  '$_downCounter presses\n$_upCounter releases',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                ),
              ],
            ),
          ),
        ));
  }
}

//----------------------------------------------------------------
class Listener01A extends StatefulWidget {
  const Listener01A({super.key});

  @override
  State<Listener01A> createState() => _Listener01AState();
}

class _Listener01AState extends State<Listener01A> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.yellowAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Tap, drag, or move your pointer here!'),
          Text(
            '$_downCounter presses\n$_upCounter releases',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
          ),
          Listener(
            onPointerDown: _incrementDown,
            onPointerMove: _updateLocation,
            onPointerUp: _incrementUp,
            child: Container(
              width: 100,
              height: 200,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
//---------------------------

class Listener02 extends StatefulWidget {
  const Listener02({super.key});

  @override
  State<Listener02> createState() => _Listener02State();
}

class _Listener02State extends State<Listener02> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(300.0, 300.0)),
      child: Listener(
        onPointerDown: _incrementDown,
        onPointerMove: _updateLocation,
        onPointerUp: _incrementUp,
        child: ColoredBox(
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                  'You have pressed or released in this area this many times:'),
              Text(
                '$_downCounter presses\n$_upCounter releases',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
