import 'dart:ui';

import 'package:flutter/material.dart';

class MyDemoUI2 extends StatelessWidget {
  const MyDemoUI2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter DemoUI2')),
        body: const UserScreen(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}
//---------------------------
// Example 1
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      /* gọi itemBuilder với index tương ứng. Trong mỗi lần này, UserCard sẽ nhận user tại index để hiển thị thông tin người dùng cho phần tử đó trong danh sách. */
      body: ListView.builder(
        itemCount: users.length, // users khai báo ở phần Dữ liệu mẫu
        itemBuilder: (context, index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }
}

// 
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(user.liked ? Icons.favorite : Icons.favorite_border),
               tooltip: user.liked ? 'Unlike' : 'Like',
              onPressed: () {
                // Xử lý khi người dùng nhấn vào biểu tượng like
              },
            ),
            IconButton(
              icon: Icon(user.going ? Icons.check_circle : Icons.add_circle_outline),
               tooltip: user.going ? 'Cancel going' : 'Mark going',
              onPressed: () {
                // Xử lý khi người dùng nhấn vào biểu tượng go
              },
            ),
            // Thêm các biểu tượng khác tương tự
          ],
        ),
      ),
    );
  }
}

// 
class User {
  final String avatarUrl;
  final String name;
  bool liked;
  bool going;

  User({
    required this.avatarUrl,
    required this.name,
    this.liked = false,
    this.going = false,
  });
}

// Dữ liệu mẫu
List<User> users = [
  User(
    avatarUrl: 'https://example.com/avatar1.png',
    name: 'User 1',
    liked: true,
    going: false,
  ),
  User(
    avatarUrl: 'https://example.com/avatar2.png',
    name: 'User 2',
    liked: false,
    going: true,
  ),
  User(
    avatarUrl: 'https://example.com/avatar1.png',
    name: 'User 3',
    liked: true,
    going: false,
  ),
  User(
    avatarUrl: 'https://example.com/avatar2.png',
    name: 'User 4',
    liked: false,
    going: true,
  ),
  User(
    avatarUrl: 'https://example.com/avatar1.png',
    name: 'User 5',
    liked: true,
    going: false,
  ),
  User(
    avatarUrl: 'https://example.com/avatar2.png',
    name: 'User 6',
    liked: false,
    going: true,
  ),
  // Thêm các user khác tương tự
];

// Example 2 - 
class User2 {
  final String avatar;
  final String name;

  User2({required this.avatar, required this.name});
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<User2> _users = [
    User2(avatar: 'assets/images/avatar1.png', name: 'User 1'),
    User2(avatar: 'assets/images/avatar2.png', name: 'User 2'),
    User2(avatar: 'assets/images/avatar3.png', name: 'User 3'),
    // Thêm thêm dữ liệu user
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the edges
                children: <Widget>[
                  Row( // Wrap this Row to keep the Avatar and Text together
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(user.avatar),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.name, style: const TextStyle(fontSize: 18.0)),
                          Text(user.avatar, style: const TextStyle(fontSize: 14.0)), // Changed fontSize for better readability
                        ],
                      ),
                    ],
                  ),
                  Row( // This Row contains the icons
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          // Handle like button press
                          print('Liked ${user.name}');
                        },
                        tooltip: 'Like',
                      ),
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: () {
                          // Handle location button press
                          print('Navigating to ${user.name}');
                        },
                        tooltip: 'Navigate',
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {
                          // Handle more button press
                          print('More info about ${user.name}');
                        },
                        tooltip: 'More',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}