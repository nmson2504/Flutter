// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/common/theme.dart';
import 'package:shopping_provider/models/cart.dart';
import 'package:shopping_provider/models/catalog.dart';
import 'package:shopping_provider/screens/cart.dart';
import 'package:shopping_provider/screens/catalog.dart';
import 'package:shopping_provider/screens/login.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        /* CatalogModel là một mô hình dữ liệu không thay đổi (immutable) trong suốt thời gian chạy ứng dụng, vì vậy chỉ cần dùng Provider đơn giản. Điều này có nghĩa là CatalogModel không cần thông báo về sự thay đổi trạng thái. */
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        /* ChangeNotifierProxyProvider: Đây là một loại Provider đặc biệt được sử dụng khi một mô hình dữ liệu (ở đây là CartModel) phụ thuộc vào một mô hình khác (ở đây là CatalogModel).
create: (context) => CartModel(): Đây là nơi CartModel được khởi tạo.
update: Trong update, CartModel sẽ nhận thêm dữ liệu từ CatalogModel. Mô hình giỏ hàng (CartModel) phụ thuộc vào CatalogModel, vì vậy chúng ta cần dùng ProxyProvider để truyền mô hình danh mục (catalog) vào mô hình giỏ hàng (cart). */
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
