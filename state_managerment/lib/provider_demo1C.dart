import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Demo thêm về ProxyProvider, ProxyProvider2 và Stream
/* 
Lưu ý:

 */
// ProxyProvider và ProxyProvider2
/* 
ProxyProvider và ProxyProvider2 là hai thành phần trong thư viện Provider của Flutter, cho phép bạn tạo ra một model mới dựa trên một hoặc nhiều model khác. Dưới đây là sự so sánh giữa hai loại này:

1. ProxyProvider
Mô tả: ProxyProvider cho phép bạn tạo ra một model mới dựa trên một model khác.
Cú pháp:
ProxyProvider<PreviousModel, NewModel>(
  update: (context, previousModel, newModel) {
    // Cập nhật NewModel dựa trên PreviousModel
    return newModel;
  },
)
Số lượng model phụ thuộc: Chỉ có một model phụ thuộc, tức là PreviousModel.
Sử dụng: Khi bạn chỉ cần một model duy nhất để tạo ra model mới.
2. ProxyProvider2
Mô tả: ProxyProvider2 mở rộng từ ProxyProvider, cho phép bạn tạo ra một model mới dựa trên hai model khác.
Cú pháp:
ProxyProvider2<PreviousModel1, PreviousModel2, NewModel>(
  update: (context, previousModel1, previousModel2, newModel) {
    // Cập nhật NewModel dựa trên PreviousModel1 và PreviousModel2
    return newModel;
  },
)
Số lượng model phụ thuộc: Có hai model phụ thuộc, tức là PreviousModel1 và PreviousModel2.
Sử dụng: Khi bạn cần kết hợp dữ liệu từ hai model để tạo ra model mới.
 */
class MyAppProvider1C extends StatelessWidget {
  const MyAppProvider1C({super.key});

  @override
  Widget build(BuildContext context) {
    return const Example01();
  }
}

// ProxyProvider

// ProxyProvider2

// Stream

// Example 1 - model có liên quan nhưng ko phụ thuộc
/* 
Product trong ví dụ chỉ là một lớp dữ liệu đơn giản chứa tên và giá sản phẩm, không có logic hoặc trạng thái cần được quản lý. Nó không thay đổi trạng thái và không cần thông báo cho bất kỳ ai về sự thay đổi của nó. Mặc dù CartModel và ProductListModel khai báo Product nhưng ko chia sẻ trạng thái gì với Product.
ProxyProvider chỉ cần thiết khi một mô hình cần truy cập đến dữ liệu của một mô hình khác, và sự phụ thuộc này có thể thay đổi theo thời gian -> trong trường hợp này không cần dùng ProxyProvider
 */
class Example01 extends StatelessWidget {
  const Example01({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ProductListModel()),
      ],
      child: const MyApp03(),
    );
  }
}

// Model cho sản phẩm
class Product {
  final String name;
  final double price;
  Product(this.name, this.price);
}

// ChangeNotifier cho giỏ hàng
class CartModel extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => _items;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

// syntax: collection.fold(initialValue, (accumulator, element) => ...)
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}

// ChangeNotifier cho quản lý người dùng
class UserModel extends ChangeNotifier {
  String? _username;
  String? get username => _username;

  void login(String username) {
    _username = username;
    notifyListeners();
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}

// ChangeNotifier cho danh sách sản phẩm
class ProductListModel extends ChangeNotifier {
  final List<Product> _products = [
    Product("Áo", 20),
    Product("Quần", 30),
    Product("Giày", 50),
  ];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}

class MyApp03 extends StatelessWidget {
  const MyApp03({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage03(),
    );
  }
}

class HomePage03 extends StatelessWidget {
  const HomePage03({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenHeight = MediaQuery.of(context).size.height;
    // Tính toán chiều cao cho SizedBox (ví dụ: 5% chiều cao màn hình)
    final spacerHeight = screenHeight * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng mua sắm 1C'),
        actions: [
          Consumer<UserModel>(
            builder: (context, userModel, child) {
              if (userModel.username == null) {
                return TextButton(
                  onPressed: () => userModel.login("NguyễnVănA"),
                  child: const Text('Đăng nhập', style: TextStyle(color: Colors.white)),
                );
              } else {
                return TextButton(
                  onPressed: () => userModel.logout(),
                  child: Text('Đăng xuất (${userModel.username})', style: const TextStyle(color: Colors.white)),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductListModel>(
              builder: (context, productListModel, child) {
                return ListView.builder(
                  itemCount: productListModel.products.length,
                  itemBuilder: (context, index) {
                    final product = productListModel.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          context.read<CartModel>().addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                                duration: const Duration(milliseconds: 500)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[200],
            child: Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return Text(
                  'Tổng giá trị giỏ hàng: \$${cartModel.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          SizedBox(height: spacerHeight), // Khoảng trống tính theo tỷ lệ màn hình
        ],
      ),
    );
  }
}
