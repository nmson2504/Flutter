import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:device_preview/device_preview.dart';

class MyHero extends StatelessWidget {
  const MyHero({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const FirstScreen(),
      2: () => const BasicHeroAnimation(),
      3: () => const BasicHeroAnimation1(),
      4: () => const BasicHeroAnimation2(),
      5: () => const BasicHeroAnimation4(),
      6: () => const BasicHeroAnimation5(),
      7: () => const BasicHeroAnimation6(),
      8: () => const MyHomePage(title: 'Hero with placeholderBuilder'),
      9: () => const HeroPlaceholderDemoApp(),
      10: () => const BasicHeroAnimation3(),
      11: () => const BasicHeroAnimation30(),
      12: () => const ScreenOne(),
      13: () => const ScreenOne1(),
      14: () => const ScreenOneK(),
      19: () => const MyHomePageX(title: 'Hero Flight Shuttle Demo'),
    };
    int n = 1; // Giá trị n có thể thay đổi
    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: bodyWidget, // Truyền Widget vào body
    );
  }
}

// Basic Hero Animations
// Example 1 - FirstScreen push SecondScreen
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' Demo1 - First Screen')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const SecondScreen();
            }));
          },
          child: Hero(
            tag: 'hero-image',
            child: Image.network(
              'https://w7.pngwing.com/pngs/923/976/png-transparent-book-library-book-rectangle-reading-presentation-thumbnail.png',
              width: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const FirstScreen();
            }));
          },
          child: Hero(
            tag: 'hero-image',
            child: Image.network(
              'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
              width: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}

// Example 2 - 2 Hero trong cùng 1 widget
class BasicHeroAnimation extends StatelessWidget {
  const BasicHeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: InkWell(
          // onTap trên Main route - moves to Destination route
          onTap: () {
            // Destination route (source hero)
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Flippers Page'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      // Use background color to emphasize that it's a new route.
                      color: Colors.lightBlueAccent,
                      child: Hero(
                        tag: 'flippers',
                        child: SizedBox(
                          width: 200,
                          child: Image.asset(
                            'images/flippers-alpha.png',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: 'flippers',
            child: Image.asset(
              'images/flippers-alpha.png',
            ),
          ),
        ),
      ),
    );
  }
}

// Example 3 - 2 Hero trong cùng 1 widget
class BasicHeroAnimation1 extends StatelessWidget {
  const BasicHeroAnimation1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 1'),
      ),
      body: Center(
        child: InkWell(
          // onTap trên Main route - moves to Destination route
          onTap: () {
            // Destination route
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      // Use background color to emphasize that it's a new route.
                      color: Colors.lightBlueAccent,
                      child: const Hero(
                        tag: "DemoTag",
                        child: Icon(
                          Icons.add,
                          size: 150.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: const Hero(
            tag: "DemoTag",
            child: Icon(
              Icons.add,
              size: 400.0,
            ),
          ),
        ),
      ),
    );
  }
}

// Example 4 - 2 Hero trong cùng 1 widget - 2 onTap .push & .pop
class BasicHeroAnimation2 extends StatelessWidget {
  const BasicHeroAnimation2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 2'),
      ),
      body: Center(
        child: InkWell(
          // onTap on Main route - moves to Destination route
          onTap: () {
            // Navigate to the Destination route
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page - click Navigate to the Destination route '),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      // Use background color to emphasize that it's a new route.
                      color: Colors.lightBlueAccent,
                      // Destination Hero with InkWell
                      child: InkWell(
                        // onTap to navigate back to the Source route
                        onTap: () {
                          Navigator.of(context).pop(); // Navigate back to the source
                        },
                        child: const Hero(
                          tag: "DemoTag",
                          child: Icon(
                            Icons.add,
                            size: 190.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: const Hero(
            tag: "DemoTag",
            child: Icon(
              Icons.add,
              size: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}

// Example 5 - Toggle Hero - AnimatedOpacity
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showHero = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showHero = !_showHero;
                });
              },
              child: const Text('Toggle Hero'),
            ),
            const SizedBox(height: 20),
            Hero(
              tag: 'heroTag',
              placeholderBuilder: (context, size, widget) {
                return Container(
                  width: 200,
                  height: 200,
                  color: const Color.fromARGB(255, 50, 7, 218),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              child: AnimatedOpacity(
                opacity: _showHero ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  'images/pavlova.jpg',
                  height: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 6 - load trang trung gian để trì hoãn cho placeholderBuilder show CircularProgressIndicator

class HeroPlaceholderDemoApp extends StatelessWidget {
  const HeroPlaceholderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Placeholder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FirstScreen6(),
    );
  }
}

class FirstScreen6 extends StatelessWidget {
  const FirstScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Navigate to loading screen with delay
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const LoadingScreen();
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 150.0,
            ),
            placeholderBuilder: (context, size, widget) {
              return Container(
                height: 150.0,
                width: 150.0,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Delay before moving to the second screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SecondScreen6(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SecondScreen6 extends StatelessWidget {
  const SecondScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Hero(
          tag: "DemoTag",
          child: const Icon(
            Icons.add_alarm,
            size: 300.0,
          ),
          placeholderBuilder: (context, size, widget) {
            return Container(
              height: 300.0,
              width: 300.0,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
//

class BasicHeroAnimation4 extends StatelessWidget {
  const BasicHeroAnimation4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 4'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Navigate to the Destination route
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page - click Navigate to the Destination route'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      color: Colors.lightBlueAccent,
                      // Destination Hero with InkWell
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(); // Navigate back to the source
                        },
                        child: Hero(
                          tag: "DemoTag",
                          child: const Icon(
                            Icons.add,
                            size: 190.0,
                          ),
                          placeholderBuilder: (context, size, widget) {
                            return Container(
                              height: 190.0,
                              width: 190.0,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 300.0,
            ),
            placeholderBuilder: (context, size, widget) {
              return Container(
                height: 300.0,
                width: 300.0,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Example - showDialog và Future.delayed trì hoãn thời gian
class BasicHeroAnimation5 extends StatelessWidget {
  const BasicHeroAnimation5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 5'),
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            // Show a loading dialog
            showDialog(
              barrierColor: const Color.fromARGB(255, 7, 61, 255),
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const AlertDialog(
                  content: CircularProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            );

            // Delay before navigating to the destination route
            await Future.delayed(const Duration(seconds: 1));

            // Dismiss the loading dialog
            Navigator.of(context).pop();

            // Navigate to the destination route
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page - click Navigate to the Destination route'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      color: Colors.lightBlueAccent,
                      // Destination Hero with InkWell
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(); // Navigate back to the source
                        },
                        child: Hero(
                          tag: "DemoTag",
                          child: const Icon(
                            Icons.add,
                            size: 190.0,
                          ),
                          placeholderBuilder: (context, size, widget) {
                            return Container(
                              height: 190.0,
                              width: 190.0,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 300.0,
            ),
            placeholderBuilder: (context, size, widget) {
              return Container(
                height: 300.0,
                width: 300.0,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Example - Dùng Overlay và Future.delayed
// OverlayEntry  tạo một lớp phủ tạm thời với CircularProgressIndicator ở trên cùng của giao diện hiện tại. Điều này giúp tạo ra một hiệu ứng loading mà không cần chuyển đến một màn hình trung gian.
class BasicHeroAnimation6 extends StatelessWidget {
  const BasicHeroAnimation6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 6'),
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            // Create a new overlay entry
            final overlay = Overlay.of(context);
            final overlayEntry = OverlayEntry(
              builder: (context) => Positioned(
                top: MediaQuery.of(context).size.height / 2 - 30,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: const Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );

            // Insert the overlay entry
            overlay.insert(overlayEntry);

            // Delay before navigating to the destination route
            await Future.delayed(const Duration(seconds: 1));

            // Remove the overlay entry
            overlayEntry.remove();

            // Navigate to the destination route
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page - click Navigate to the Destination route'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      color: Colors.lightBlueAccent,
                      // Destination Hero with InkWell
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(); // Navigate back to the source
                        },
                        child: Hero(
                          tag: "DemoTag",
                          child: const Icon(
                            Icons.add,
                            size: 190.0,
                          ),
                          placeholderBuilder: (context, size, widget) {
                            return Container(
                              height: 190.0,
                              width: 190.0,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 300.0,
            ),
            placeholderBuilder: (context, size, widget) {
              return Container(
                height: 300.0,
                width: 300.0,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Example - thuộc tính flightShuttleBuilder - tùy chỉnh cách Hero bay giữa hai điểm
class BasicHeroAnimation3 extends StatelessWidget {
  const BasicHeroAnimation3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation - flightShuttleBuilder'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      color: Colors.lightBlueAccent,
                      // Destination Hero
                      child: Hero(
                        tag: "DemoTag",
                        child: const Icon(
                          Icons.add,
                          size: 150.0,
                        ),
                        // set icon bay đến Destination hero
                        flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
                          //  ScaleTransition để tạo hiệu ứng phóng to/thu nhỏ cho biểu tượng khi nó bay giữa hai màn hình.
                          return ScaleTransition(
                            scale:
// begin: 0.5: Điểm bắt đầu của hoạt ảnh là 0.5, nghĩa là widget sẽ bắt đầu với kích thước nhỏ hơn (50% so với kích thước ban đầu).
// end: 1.0: Điểm kết thúc của hoạt ảnh là 1.0, nghĩa là widget sẽ đạt kích thước hoàn chỉnh (100% kích thước ban đầu) khi hoạt ảnh kết thúc.
                                animation.drive(Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
                            child: const Icon(
                              Icons.add,
                              size: 150.0,
                              color: Colors.pink,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 300.0,
            ),
            // set icon bay về source hero
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              // Using flightShuttleBuilder to show CircularProgressIndicator during transition
              return Stack(
                alignment: Alignment.center,
                children: [
                  ScaleTransition(
                    scale: animation.drive(Tween(begin: 0.2, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
                    child: const Icon(
                      Icons.add,
                      size: 300.0,
                      color: Colors.green,
                    ),
                  ),
                  const CircularProgressIndicator(), // Show loading indicator during the transition
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Example - flightShuttleBuilder với PageRouteBuilder.transitionDuration chỉnh time

class BasicHeroAnimation30 extends StatelessWidget {
  const BasicHeroAnimation30({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation 30'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Sử dụng PageRouteBuilder để tùy chỉnh thời gian chuyển đổi
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Destination Page'),
                    ),
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      color: Colors.lightBlueAccent,
                      // Destination Hero
                      child: Hero(
                        tag: "DemoTag",
                        child: const Icon(
                          Icons.add,
                          size: 150.0,
                        ),
                        flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
                          return ScaleTransition(
                            scale:
                                animation.drive(Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
                            child: const Icon(
                              Icons.add,
                              size: 150.0,
                              color: Colors.pink,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                transitionDuration: const Duration(seconds: 2), // Điều chỉnh thời gian bay (2 giây)
              ),
            );
          },
          // Main route (source hero)
          child: Hero(
            tag: "DemoTag",
            child: const Icon(
              Icons.add,
              size: 150.0,
            ),
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ScaleTransition(
                    scale: animation.drive(Tween(begin: 1.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
                    child: const Icon(
                      Icons.add,
                      size: 15.0,
                      color: Colors.green,
                    ),
                  ),
                  const CircularProgressIndicator(), // Hiển thị vòng tròn loading trong quá trình bay
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
// Example - 2 screen dùng HeroFlightDirection

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 1'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Tap on the rocket to go to Screen 2'),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ScreenTwo()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  color: Colors.lightBlueAccent,
                  child: Hero(
                    tag: 'rocketHero',
                    flightShuttleBuilder: (flightContext, animation, direction, fromHeroContext, toHeroContext) {
                      // Tùy chỉnh icon dựa trên hướng push hoặc pop
                      if (direction == HeroFlightDirection.push) {
                        return const Icon(
                          FontAwesomeIcons.rocket,
                          size: 150.0,
                        );
                      } else if (direction == HeroFlightDirection.pop) {
                        return const Icon(
                          FontAwesomeIcons.rocket,
                          size: 70.0,
                        );
                      }
                      return const Icon(FontAwesomeIcons.rocket);
                    },
                    child: const Icon(
                      FontAwesomeIcons.ad,
                      size: 100.0, // Biểu tượng rocket ban đầu ở màn hình 1
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('Tap on the rocket to go back to Screen 1'),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Hero(
                  tag: 'rocketHero',
                  flightShuttleBuilder: (flightContext, animation, direction, fromHeroContext, toHeroContext) {
                    // Tùy chỉnh icon dựa trên hướng push hoặc pop
                    if (direction == HeroFlightDirection.push) {
                      return const Icon(
                        FontAwesomeIcons.rocket,
                        size: 70.0,
                      );
                    } else if (direction == HeroFlightDirection.pop) {
                      return const Icon(
                        FontAwesomeIcons.rocket,
                        size: 150.0,
                      );
                    }
                    return const Icon(FontAwesomeIcons.rocket);
                  },
                  child: const Icon(
                    FontAwesomeIcons.addressBook,
                    size: 70.0, // Biểu tượng rocket ở màn hình 2
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example - flightShuttleBuilder - Toggle Hero - ko thấy hình thứ 2

class MyHomePageX extends StatefulWidget {
  const MyHomePageX({super.key, required this.title});

  final String title;

  @override
  State<MyHomePageX> createState() => _MyHomePageXState();
}

class _MyHomePageXState extends State<MyHomePageX> {
  bool _showHero = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showHero = !_showHero;
                });
              },
              child: const Text('Toggle Hero'),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: 'heroTag',
              child: AnimatedOpacity(
                opacity: _showHero ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: Image.asset(
                  'images/flippers-alpha.png',
                  height: 400,
                ),
              ),
              /* 
flightContext: Context của widget chuyển tiếp.
animation: Một Animation object để điều khiển hoạt ảnh.
direction: Chiều của chuyển tiếp (forward hoặc reverse).
fromHeroContext: Context của Hero ở màn hình trước.
toHeroContext: Context của Hero ở màn hình sau.
               */
              flightShuttleBuilder: (flightContext, animation, direction, fromHeroContext, toHeroContext) {
                return DefaultTextStyle(
                  style: DefaultTextStyle.of(toHeroContext).style,
                  child: ScaleTransition(
                    scale:
                        animation.drive(Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
                    child: Image.asset(
                      'images/day-night.png',
                      height: 200,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//

class ScreenOne1 extends StatelessWidget {
  const ScreenOne1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScreenOne1 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tap on the rocket to go to Screen 2'),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScreenTwo1()),
                );
              },
              child: Hero(
                tag: 'rocketHero',
                transitionOnUserGestures: true, // Bật thuộc tính transition khi người dùng vuốt
                flightShuttleBuilder: (flightContext, animation, direction, fromHeroContext, toHeroContext) {
                  // Chuyển tiếp khi push hoặc pop
                  if (direction == HeroFlightDirection.push) {
                    return const Icon(
                      FontAwesomeIcons.rocket,
                      size: 150.0,
                    );
                  } else if (direction == HeroFlightDirection.pop) {
                    return const Icon(
                      FontAwesomeIcons.rocket,
                      size: 70.0,
                    );
                  }
                  return const Icon(FontAwesomeIcons.rocket);
                },
                child: const Icon(
                  FontAwesomeIcons.rocket,
                  size: 150.0, // Biểu tượng rocket ban đầu ở màn hình 1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenTwo1 extends StatelessWidget {
  const ScreenTwo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tap on the rocket to go back to Screen 1'),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(); // Quay lại màn hình đầu tiên
              },
              child: Hero(
                tag: 'rocketHero',
                transitionOnUserGestures: true, // Cho phép chuyển tiếp khi vuốt để pop
                flightShuttleBuilder: (flightContext, animation, direction, fromHeroContext, toHeroContext) {
                  if (direction == HeroFlightDirection.push) {
                    return const Icon(
                      FontAwesomeIcons.rocket,
                      size: 150.0,
                    );
                  } else if (direction == HeroFlightDirection.pop) {
                    return const Icon(
                      FontAwesomeIcons.rocket,
                      size: 70.0,
                    );
                  }
                  return const Icon(FontAwesomeIcons.rocket);
                },
                child: const Icon(
                  FontAwesomeIcons.rocket,
                  size: 70.0, // Biểu tượng rocket ở màn hình 2
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//

class ScreenOneK extends StatelessWidget {
  const ScreenOneK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 1K'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ScreenTwoK()),
            );
          },
          child: Hero(
            tag: 'heroTag',
            transitionOnUserGestures: true, // Kích hoạt hiệu ứng khi chạm
            child: Image.asset(
              'images/avatar2.png',
              width: 150.0,
              height: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenTwoK extends StatelessWidget {
  const ScreenTwoK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2K'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: 'heroTag',
            transitionOnUserGestures: true, // Cho phép vuốt để quay lại
            child: Image.asset(
              'images/avatar1.png',
              width: 300.0,
              height: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}
