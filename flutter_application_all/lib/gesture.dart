import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyGesture extends StatelessWidget {
  const MyGesture({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter GestureDetector')),
        body: const Gesture01A(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//---------------------------
// GestureDetector set child property

class Gesture01 extends StatefulWidget {
  const Gesture01({super.key});

  @override
  State<Gesture01> createState() => _Gesture01State();
}

class _Gesture01State extends State<Gesture01> {
  bool _lightIsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.lightbulb_outline,
                color: _lightIsOn ? Colors.yellow.shade600 : Colors.black,
                size: 60,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle light when tapped.
                  _lightIsOn = !_lightIsOn;
                });
              },
              child: Container(
                color: const Color.fromARGB(255, 172, 171, 161),
                padding: const EdgeInsets.all(8),
                // Change button text when light changes state.
                child: Text(_lightIsOn ? 'TURN LIGHT OFF' : 'TURN LIGHT ON'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------------------------
class Gesture01A extends StatelessWidget {
  const Gesture01A({super.key});

  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        const snackBar = SnackBar(content: Text('Tap'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      // The custom button
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('My Button'),
      ),
    );
  }
}

//---------------------------
// GestureDetector not set child property
/// GestureDetector does not have a child, it takes on the size of its parent, making the entire area of the surrounding Container clickable.
class Gesture02 extends StatefulWidget {
  const Gesture02({super.key});

  @override
  State<Gesture02> createState() => _Gesture02State();
}

class _Gesture02State extends State<Gesture02> {
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: _color,
      height: 400,
      width: 400.0,
      decoration: BoxDecoration(
          color: _color, border: Border.all(width: 2, color: Colors.black)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _color == Colors.yellow
                ? _color = Colors.white
                : _color = Colors.yellow;
          });
        },
      ),
    );
  }
}

//----------------------------------------------------------------
// GestureDetectors nested
//  The key concept here is the "first come, first served" principle in gesture recognition. - Child GestureDetectors action is parent GestureDetectors not action
class Gesture03 extends StatefulWidget {
  const Gesture03({super.key});

  @override
  State<Gesture03> createState() => _Gesture03State();
}

class _Gesture03State extends State<Gesture03> {
  void _handleParentTap() {
    print('Parent GestureDetector tapped!');
  }

  void _handleChildTap() {
    print('Child GestureDetector tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleParentTap, // Parent GestureDetector onTap callback
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: GestureDetector(
          onTap: _handleChildTap, // Child GestureDetector onTap callback
          child: const Center(
            child: Text(
              'Tap me!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//
// Gesture04
enum _OnTapWinner { none, yellow, green }

class Gesture04 extends StatefulWidget {
  const Gesture04({super.key});

  @override
  State<Gesture04> createState() => _Gesture04State();
}

class _Gesture04State extends State<Gesture04> {
  bool _isYellowTranslucent = false;
  _OnTapWinner _winner = _OnTapWinner.none;
  final Border highlightBorder =
      Border.all(color: Colors.red, width: 5); // define Border object

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              debugPrint('Green onTap');
              setState(() {
                _winner = _OnTapWinner.green;
              });
            },
            onTapDown: (_) => debugPrint('Green onTapDown'),
            onTapCancel: () => debugPrint('Green onTapCancel'),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: _winner == _OnTapWinner.green ? highlightBorder : null,
                color: Colors.green,
              ),
              child: GestureDetector(
                // Setting behavior to transparent or opaque as no impact on
                // parent-child hit testing. A tap on 'Yellow' is also in
                // 'Green' bounds. Both enter the gesture arena, 'Yellow' wins
                // because it is in front.
                behavior: _isYellowTranslucent
                    ? HitTestBehavior.translucent
                    : HitTestBehavior.opaque,
                onTap: () {
                  debugPrint('Yellow onTap');
                  setState(() {
                    _winner = _OnTapWinner.yellow;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border:
                        _winner == _OnTapWinner.yellow ? highlightBorder : null,
                    color: Colors.amber,
                  ),
                  width: 200,
                  height: 200,
                  child: Text(
                    'HitTextBehavior.${_isYellowTranslucent ? 'translucent' : 'opaque'}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ElevatedButton(
                child: const Text('Reset'),
                onPressed: () {
                  setState(() {
                    _isYellowTranslucent = false;
                    _winner = _OnTapWinner.none;
                  });
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                child: Text(
                  'Set Yellow behavior to ${_isYellowTranslucent ? 'opaque' : 'translucent'}',
                ),
                onPressed: () {
                  setState(() => _isYellowTranslucent = !_isYellowTranslucent);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    debugPrintGestureArenaDiagnostics = false;
    super.dispose();
  }
}

// Gesture05

class Gesture05 extends StatefulWidget {
  const Gesture05({super.key});

  @override
  State<Gesture05> createState() => _Gesture05State();
}

class _Gesture05State extends State<Gesture05> {
  bool _isYellowTranslucent = false;
  _OnTapWinner _winner = _OnTapWinner.none;
  String _tapInfo = '';
  String _hitTestBehaviorInfo = '';
  final Border highlightBorder = Border.all(color: Colors.red, width: 5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _winner = _OnTapWinner.green;
                _tapInfo = 'Green tapped!';
              });
            },
            onTapDown: (_) {
              setState(() {
                _tapInfo = 'Green onTapDown';
              });
            },
            onTapCancel: () {
              setState(() {
                // để giữ value của biến gán trong GestureDetector con thì phải ko gán tại GestureDetector cha(gán tại GestureDetector luôn ghi đè lại dù HitTestBehavior có là giá trị nào)
                // _tapInfo = 'Green onTapCancel';
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: _winner == _OnTapWinner.green ? highlightBorder : null,
                color: Colors.green,
              ),
              child: GestureDetector(
                behavior: _isYellowTranslucent
                    ? HitTestBehavior.translucent
                    : HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _winner = _OnTapWinner.yellow;
                    _tapInfo = 'Yellow tapped!';
                  });
                },
                onTapDown: (_) {
                  setState(() {
                    _tapInfo = 'Yellow onTapDown';
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _tapInfo = 'Yellow onTapCancel';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border:
                        _winner == _OnTapWinner.yellow ? highlightBorder : null,
                    color: Colors.amber,
                  ),
                  width: 250,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tap Info: $_tapInfo',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Winner: $_winner',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'HitTestBehavior: ${_isYellowTranslucent ? 'translucent' : 'opaque'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ElevatedButton(
                child: const Text('Reset'),
                onPressed: () {
                  setState(() {
                    _isYellowTranslucent = false;
                    _winner = _OnTapWinner.none;
                    _tapInfo = '';
                  });
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                child: Text(
                  'Set Yellow behavior to ${_isYellowTranslucent ? 'opaque' : 'translucent'}',
                ),
                onPressed: () {
                  setState(() {
                    _isYellowTranslucent = !_isYellowTranslucent;
                    _hitTestBehaviorInfo =
                        'HitTestBehavior: ${_isYellowTranslucent ? 'translucent' : 'opaque'}';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
