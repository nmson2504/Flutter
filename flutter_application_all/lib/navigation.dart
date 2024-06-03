import 'package:flutter/material.dart';

class MyNavigation extends StatelessWidget {
  const MyNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator1();
  }
}

// Navigator1 - navigate between two routes
// Navigator.push/pop
class Navigator1 extends StatelessWidget {
  const Navigator1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Navigation Sample')),
        body: const FirstRoute(),
      ),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
          child: const Text('Click Here'),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            true, // ẩn nút back trên appbar. If leading widget is not null, this parameter has no effect.
        title: const Text('SecondRoute Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
          onPressed: () {
            // Navigator.pop(context); // 2 cách này tuong đương nhau
            Navigator.of(context).pop();
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}

// Navigator2 - navigate between two routes
// Named routes are no longer recommended for most applications. For more information, see Limitations in the navigation overview page.
// Navigator.pushNamed
class Navigator2 extends StatelessWidget {
  const Navigator2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      // It start the app with the "/" named route. In this case, the app starts
      // on the HomeScreen widget.
      initialRoute:
          '/', // The initialRoute property defines which route the app should start with
      // Warning: When using initialRoute, don’t define a home property.(2 thuộc tính này của MaterialApp ko thể dùng đồng thời)
      routes: {
        // When navigating to the "/" route, build the HomeScreen widget.
        '/': (context) => const HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const SecondScreen2(),
      },
      // home: Scaffold(
      //   appBar: AppBar(title: const Text('Navigation Sample')),
      //   body: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
          onPressed: () {
            // Navigator.pushNamed(context, '/second'); // 2 cách này tuong đương nhau
            Navigator.of(context).pushNamed('/second');
          },
          child: const Text('Click Here'),
        ),
      ),
    );
  }
}

class SecondScreen2 extends StatelessWidget {
  const SecondScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}

// Navigator3
// Animate a widget across screens

class Navigator3 extends StatelessWidget {
  const Navigator3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Transition Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DetailScreen();
          }));
        },
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: SizedBox(
              width: 300,
              height: 300,
              child: Image.network(
                fit: BoxFit.cover,
                'https://picsum.photos/250?image=9',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Navigator5 - onGenerateRoute - có pass arguments to a named route
// onGenerateRoute is called if the routeName is not found in the routes table.
// onGenerateRoute is used to dynamically generate routes.
/// onGenerateRoute thường được sử dụng khi bạn muốn xác định các routes không cố định từ trước (như '/home', '/profile') mà dựa vào logic hoặc dữ liệu động.
/// Về cơ bản, onGenerateRoute là một thuộc tính của widget MaterialApp cho phép bạn xác định một hàm callback để tạo các routes dựa trên dữ liệu động hoặc logic của ứng dụng. Callback này sẽ được gọi khi có yêu cầu điều hướng mới và nó sẽ trả về một Route tương ứng cho route đó.
class Navigator5 extends StatelessWidget {
  const Navigator5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // {Route<dynamic>? Function(RouteSettings)? onGenerateRoute} .Settings chứa thông tin về route
        /// settings có 2 thuộc tính: const RouteSettings({String? name,Object? arguments})
        // Kiểm tra tên route và trả về màn hình tương ứng
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) {
            return const HomeScreen5();
          });
        } else if (settings.name == '/profile') {
          // Lấy thông tin người dùng từ settings.arguments ( Navigator.pushNamed(context, '/profile', arguments: 'user123');)
          final userId = settings.arguments as String;
          return MaterialPageRoute(builder: (context) {
            return UserProfilePage(
                userId:
                    userId); // Truyền thông tin người dùng vào màn hình UserProfilePage
          });
        } else if (settings.name == '/settings') {
          return MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          });
        } else if (settings.name == '/default') {
          return MaterialPageRoute(builder: (context) {
            return const DefaultPage();
          });
        }
        // Trả về màn hình mặc định nếu không tìm thấy route nào
        return MaterialPageRoute(builder: (context) {
          return const DefaultPage();
        });
      },
      initialRoute: '/', // Route mặc định khi start app
      // Các thuộc tính khác của MaterialApp
    );
  }
}

class HomeScreen5 extends StatelessWidget {
  const HomeScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến route '/profile' truyền theo thông tin người dùng
                Navigator.pushNamed(context, '/profile', arguments: 'user123');

                /// Future<T?> pushNamed<T extends Object?>( BuildContext context, String routeName, {Object? arguments,})
              },
              child: const Text('Go to Profile - user123'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến route '/profile' với thông tin người dùng
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Go to Settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến route '/profile' với thông tin người dùng
                Navigator.pushNamed(context, '/default');
              },
              child: const Text('Go to Default Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String userId;

  const UserProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Text(
            'User ID: $userId'), // Hiển thị thông tin người dùng được truyền từ route
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Page'),
      ),
      body: const Center(
        child: Text('Default Page'),
      ),
    );
  }
}

// Navigator6 - Pass arguments to a named route using ModalRoute.of() and onGenerateRoute()
/// Trong MaterialApp, khi bạn đã khai báo các routes bằng thuộc tính routes, Flutter ưu tiên sử dụng các routes đã đăng ký trong routes và sẽ bỏ qua việc sử dụng onGenerateRoute cho các route đó. Điều này có nghĩa là bạn không cần phải khai báo các routes đã có trong routes trong onGenerateRoute.
class Navigator6 extends StatelessWidget {
  const Navigator6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // Register the widget in the routes table - ExtractArgumentsScreen đã khai báo ở dưới
        ExtractArgumentsScreen.routeName: (context) => //
            const ExtractArgumentsScreen(), // chỉ gọi screen, việc extract arguments sẽ được thực hiện trong ExtractArgumentsScreen
      },
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // PassArgumentsScreen, ScreenArguments đã khai báo ở dưới
          // Cast the arguments to the correct type: ScreenArguments. (class ScreenArguments định nghĩa tham sô truyền dùng cho cả 2 màn hình)
          final args = settings.arguments as ScreenArguments;

          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                // PassArgumentsScreen đã khai báo ở dưới, extract arguments và truyền cho screen ngay tại đây
                title: args.title,
                message: args.message,
              );
            },
          );
        }
// assert(false, 'Need to implement ${settings.name}'); ném ra một ngoại lệ và thông báo lỗi nếu một tên đường dẫn (route name) không khớp với bất kỳ đường dẫn nào đã được đăng ký.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Navigation with Arguments',
      home: const HomeScreen6(),
    );
  }
}

class HomeScreen6 extends StatelessWidget {
  const HomeScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen
                      .routeName, // get route name từ ExtractArgumentsScreen
                  arguments: ScreenArguments(
                    // truyền arguments cho route qua class ScreenArguments đã được khai báo ở dưới
                    'ExtractArgumentsScreen - ${ExtractArgumentsScreen.routeName}',
                    'This message is extracted in the build method.',
                  ),
                );
              },
              child: const Text('Navigate to screen that extracts arguments'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen
                      .routeName, // get route name từ PassArgumentsScreen
                  arguments: ScreenArguments(
                    // truyền arguments cho route qua class ScreenArguments đã được khai báo ở dưới
                    'PassArgumentsScreen - ${PassArgumentsScreen.routeName}',
                    'This message is extracted in the onGenerateRoute '
                        'function.',
                  ),
                );
              },
              child: const Text('Navigate to a named that accepts arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});

  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    // ModalRoute.of(context)!.settings.arguments truy cập thuộc tính settings của đối tượng đường dẫn hiện tại. settings chứa thông tin về đối tượng đường dẫn, bao gồm các đối số (arguments).
    // as ScreenArguments ép kiểu dữ liệu từ đối tượng được trả về thành ScreenArguments. Điều này giả định rằng dữ liệu trong đối tượng đường dẫn được truyền theo kiểu ScreenArguments.
    // Cách này ko cần khai báo các biến tham số cần truyền, thay vào đó là extract từ đối tượng đường dẫn hiện tại
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

// A Widget that accepts the necessary arguments via the
// constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor
  // parameters. It does not extract the arguments from
  // the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute
  // function provided to the MaterialApp widget.
  const PassArgumentsScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

// ScreenArguments là một class chứa các tham số truyền cho cả 2 màn hình ExtractArgumentsScreen và PassArgumentsScreen
// class that contains both customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

// Navigator6a - Pass multi arguments, get route name
// Dùng ModalRoute.of(context) get được route name cho cả hai cách khai báo: 1. onGenerateRoute 2. MaterialApp.routes. Tuy nhiên, khi khai báo với onGenerateRoute thì khi gọi widget MaterialPageRoute phải truyền theo tham số RouteSettings? settings (Nói cách khác dùng .push hay .pushNamed đều phải truyền theo tham số RouteSettings thì mới get được route name bằng ModalRoute.of(context)?.settings.name)
class Navigator6a extends StatelessWidget {
  const Navigator6a({super.key});

  @override
  Widget build(BuildContext context) {
    void showWeather(BuildContext context) {
      Navigator.pushNamed(
        context,
        '/screen1',
        arguments: <String, String>{
          'city': 'Berlin',
          'country': 'Germany',
        },
      );
    }

    void showWeatherClass(BuildContext context) {
      Navigator.pushNamed(
        context,
        '/screen2',
        arguments: WeatherRouteArguments(city: 'Berlin', country: 'Germany'),
      );
    }

    void showWeatherClass1(BuildContext context) {
      Navigator.pushNamed(
        context,
        '/screen3',
        arguments: WeatherRouteArguments(city: 'Berlin', country: 'Germany'),
      );
    }

    return MaterialApp(
        routes: {
          // các routes đã đăng ký ở đây thì ko cần khai báo trong onGenerateRoute (Flutter ưu tiên chạy routes đăng ký ở đây và bỏ qua ở onGenerateRoute)
          // '/screen1': (context) => const MyWidget6a(
          //       arguments: {},
          //     ),
          '/screen21': (context) => MyWidget6b(
                arguments: WeatherRouteArguments(
                    city: 'Hà Lội',
                    country:
                        'Vịt Lam'), // values truyền tại đây sẽ ghi đè lên values truyền trong hàm _showWeatherClass
              ),
          '/screen3': (context) => MyWidget6b(
                arguments: WeatherRouteArguments(
                    city: 'Hồ Bả Chó',
                    country:
                        'from routes:'), // values truyền tại đây sẽ ghi đè lên values truyền trong hàm _showWeatherClass1
              ),
          // Các routes khác
        },
        onGenerateRoute: (settings) {
          // If you push the PassArguments route
          if (settings.name == '/screen1') {
            // truyền arguments cho route với kiểu Map<String, String> để tương ứng kiểu trong hàm _showWeather
            final data = settings.arguments as Map<String, String>;

            return MaterialPageRoute(
              builder: (context) {
                return MyWidget6a(arguments: data);
              },
            );
          } else if (settings.name == '/screen2') {
            // truyền arguments cho route với kiểu WeatherRouteArguments để tương ứng kiểu trong hàm _showWeatherClass
            final data = settings.arguments as WeatherRouteArguments;
            return MaterialPageRoute(
              builder: (context) {
                return MyWidget6b(arguments: data);
              },
            );
          } else if (settings.name == '/screen3') {
            // truyền arguments cho route bằng kiểu WeatherRouteArguments với các values ngay khi gọi hàm .pushNamed
            // values truyền tại đây sẽ ghi đè lên values truyền trong hàm _showWeatherClass1
            return MaterialPageRoute(
              builder: (context) {
                return MyWidget6b(
                    arguments: WeatherRouteArguments(
                        city: 'Hồ Bả Chó', country: 'Đông Lào'));
              },
            );
          }
// assert(false, 'Need to implement ${settings.name}'); ném ra một ngoại lệ và thông báo lỗi nếu một tên đường dẫn (route name) không khớp với bất kỳ đường dẫn nào đã được đăng ký.
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        title: 'Navigation Pass with Multi Arguments',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Navigation Pass with Multi Arguments'),
          ),
          body: Builder(builder: (context) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Điều hướng đến route
                      showWeather(context);
                    },
                    child: const Text('Go to _showWeather'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Điều hướng đến route
                      showWeatherClass(context);
                    },
                    child: const Text('Go to _showWeatherClass'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Điều hướng đến route
                      showWeatherClass1(context);
                    },
                    child: const Text('Go to _showWeatherClass with values'),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}

class MyWidget6a extends StatelessWidget {
  final Map<String, String> arguments;
  const MyWidget6a({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    String? currentRouteName = ModalRoute.of(context)
        ?.settings
        .name; //  Dùng .push hay .pushNamed đều phải truyền theo tham số RouteSettings thì mới get được route name bằng ModalRoute.of(context)?.settings.name)
    String k = 'route name is...';
    if (currentRouteName != null) {
      k = currentRouteName;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWidget6a  $k'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('MyWidget6a - $arguments'),
          Text('MyWidget6a - ${arguments['city']} - ${arguments['country']}'),
        ]),
      ),
    );
  }
}

class MyWidget6b extends StatelessWidget {
  final WeatherRouteArguments arguments;
  const MyWidget6b({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    String? currentRouteName = ModalRoute.of(context)
        ?.settings
        .name; // phải đăng ký trước trong thuộc tính routes của MaterialApp
    String k = '';
    if (currentRouteName != null) {
      k = currentRouteName;
    } else {
      // Xử lý khi không có đường dẫn hiện tại
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('MyWidget6b $k'),
      ),
      body: Center(
        child: Text('${arguments.country} - ${arguments.city}'),
      ),
    );
  }
}

class WeatherRouteArguments {
  WeatherRouteArguments({this.city, this.country});
  final String? city;
  final String? country;

  bool get isGermanCapital {
    return country == 'Germany' && city == 'Berlin';
  }
}

// Navigator6b - Get route name bằng 2 cách: 1. onGenerateRoute 2. settings.name
/// Dùng ModalRoute.of(context) get được route name cho cả hai cách Navigator.push và .pushName. Cụ thể:
///  - Dùng Navigator.push: truyền route name ngay trong phương thức .push (ko liên quan MaterialApp.router và onGenerateRoute)
///  - Dùng Navigator.pushNamed: chỉ truyển route name trong onGenerateRoute
/// (Nói cách khác dùng .push phải truyền theo RouteSettings, dùng .pushNamed chỉ cần truyền RouteSettings trong onGenerateRoute thì sẽ get được route name bằng ModalRoute.of(context)?.settings.name)

class Navigator6b extends StatelessWidget {
  const Navigator6b({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home', // Đặt route khởi đầu
      onGenerateRoute: (settings) {
        // phải gán RouteSettings nếu muốn lấy route name tại màn hình đích
        switch (settings.name) {
          case '/profile':
            return MaterialPageRoute(
              builder: (context) => const ProfileScreen2(),
            ); // Phải gán route name ở đây, để UI có thể get ra bằng ModalRoute.of(context)?.settings.name;
          case '/profile2':
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen2(),
                settings: settings); // Gán tên route ở đây
          default:
            return null; // Trả về null cho các route không hợp lệ
        }
      },
      routes: {
        // ko cần gán RouteSettings tại đây
        '/home': (context) => const HomeScreen6b(),
        '/profile': (context) => const ProfileScreen(),
      },
      // Các thuộc tính khác của MaterialApp
    );
  }
}

class HomeScreen6b extends StatelessWidget {
  const HomeScreen6b({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Chuyển đến màn hình ProfileScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                    settings: const RouteSettings(
                        name:
                            '/profile'), // bắt buộc truyền theo route name ở đây, để UI có thể get ra bằng ModalRoute.of(context)?.settings.name;
                  ),
                );
              },
              child: const Text(
                  'Go to Profile - .push với MaterialPageRoute có settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến màn hình ProfileScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const Text(
                  'Go to Profile - .push với MaterialPageRoute ko có settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến màn hình ProfileScreen
                Navigator.pushNamed(context,
                    '/profile'); // Nếu đi qua onGenerateRoute phải truyền route name, còn đi qua MaterialApp.routes ko cần truyền, để UI có thể get ra bằng ModalRoute.of(context)?.settings.name;
              },
              child:
                  const Text('Go to Profile - Navigator.pushNamed - /profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến màn hình ProfileScreen2
                Navigator.pushNamed(context,
                    '/profile2'); // .pushNamed(context, '/profile2') tương đương với .push(context, MaterialPageRoute(builder: (context) => const ProfileScreen2(),settings: const RouteSettings(name: '/profile2'),),);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ProfileScreen2(),
                //     settings: const RouteSettings(
                //         name: '/profile2'), // Đặt tên route ở đây
                //   ),
                // );
              },
              child: const Text('Go to Navigator.pushNamed - Profile2'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy tên của route từ settings
    final routeName = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Route Name: $routeName'), // Hiển thị tên của route
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Chuyển trở lại màn hình trước đó
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen2 extends StatelessWidget {
  const ProfileScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy tên của route từ settings
    final routeName = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Route Name: $routeName'), // Hiển thị tên của route
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Chuyển trở lại màn hình trước đó
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigator7 - return new page trực tiếp luôn tại hàm Navigator.push
class Navigator7 extends StatelessWidget {
  const Navigator7({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppBarExample(),
    );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator7 Demo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      // return new page trực tiếp luôn
                      appBar: AppBar(
                        automaticallyImplyLeading:
                            false, // ẩn nút back (mũi tên back trên AppBar). If leading widget is not null, this parameter has no effect.
                        title: const Text('Next page'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
