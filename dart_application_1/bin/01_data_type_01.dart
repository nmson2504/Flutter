void main() {
  // INT - DOUBLE - NUMBER - BOOLEAN
  int n = 123;
  print('n: ${n}');
  // n = 12.8; // ko cho int gán qua double
  // n = 'aaaaaaaaa'; // ko cho phep gan qua data type khác (phải casting)

  double d = 2.6;
  print('d: ${d}');
  d = 100; // double gán được value int nhưng print ra sẽ show .0
  print('d: ${d}');

// number gán được cả int và double
  num number1 = 34;
  print(number1);
  num number2 = 23.76;
  print('number2: ${number2}');

// STRING
  String ch = 'chxhchtl';
  print('ch: ${ch}');

// BOOLEAN
  bool dung = true;
  print('dung: ${dung}');
  bool sai = false;
  print('sai: ${sai}');

// Kiem tra data type
  print('n: ${n} - data type: ${n.runtimeType}');
  print('d: ${d} - data type: ${d.runtimeType}');
  print('number: ${number1} - data type: ${number1.runtimeType}');
  print('sai: ${sai} - data type: ${sai.runtimeType}');

  // MỘT SỐ CÚ SYNTAX PRINT GHÉP SỐ VÀ STRING
  // dùng toán tử + và method .toString
  print('I am ' + number1.toString() + ' age.');
  // dùng chỉ thị ${var_name}
  print('number1: ${number1}');
  // chỉ dung chỉ thị $
  print('number1 = $number1');

// chèn specials character vào string
  String ch1 = 'I\'m a supper man! \$\$\$';
  print('ch: ${ch1}');
// chỉ thị \n xuống dòng string
  String ch2 =
      'Toi la Nguyen Minh Son, sinh 25/04/1975 \n Noi sinh: Sai Gon, BV Hùng Vương';
  print('ch2: ${ch2}');

// ----------CASTING---------------------
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------CASTING------------"); // just to show where the cursor is
// http://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
  String so = '123';
  double a_float = double.parse(so);
  print('a_float: ${a_float} - data type: ${a_float.runtimeType}');
  int a_int = int.parse(so);
  print('a_int: ${a_int} - data type: ${a_int.runtimeType}');
  num a_num = int.parse(so);
  print('a_num: ${a_num} - data type: ${a_num.runtimeType}');

  // casting from double to int
  double f1 = 7.5;
  double f2 = 7.6;
  double f3 = 7.4;
  // .toInt - cắt phần decimal
  int n1 = f1.toInt();
  print('n1: ${n1}');
  int n2 = f2.toInt();
  print('n2: ${n2}');
  int n3 = f3.toInt();
  print('n3: ${n3}');
// .truncate cũng cắt decimal
  int n4 = f1.truncate();
  // .round làm tròn lên nếu decimal >=5, tròn xuống nếu <5
  print('n4: ${n4}');
  int n5 = f1.round();
  print('n5: ${n5}');
  int n6 = f3.round();
  print('n6: ${n6}');

  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------VAR------------"); // just to show where the cursor is
//
// CÁC KEYWORDS VAR
/* từ khóa "var" được sử dụng để khai báo biến mà không cần chỉ định kiểu dữ liệu của biến tại thời điểm khai báo. Thay vào đó, kiểu dữ liệu của biến được suy luận tự động dựa trên giá trị được gán cho biến.
Lưu ý rằng một biến được khai báo bằng "var" sẽ có kiểu dữ liệu được xác định tại thời điểm gán giá trị ban đầu và sẽ không thay đổi sau đó. Nếu bạn cần thay đổi kiểu dữ liệu của biến sau khi đã khai báo, bạn cần tạo một biến mới hoặc sử dụng từ khóa "dynamic". */
  var x = 123;
  print('x: ${x} - type: ${x.runtimeType}');
  var y = 45.32;
  var z = 'mot tram muoi hai';

  // keyword dynamic
/*   "dynamic" được sử dụng để khai báo biến mà kiểu dữ liệu của nó có thể thay đổi trong quá trình chạy (runtime). Khi một biến được khai báo với từ khóa "dynamic", Dart sẽ không kiểm tra kiểu dữ liệu của biến khi biên dịch, và thay vào đó sẽ xác định kiểu dữ liệu của biến tại thời điểm chạy.
  Lưu ý rằng việc sử dụng "dynamic" có thể làm mất đi tính tự động kiểm tra kiểu dữ liệu của Dart, dẫn đến một số vấn đề liên quan đến kiểm tra kiểu và hiệu suất trong mã. Do đó, nên hạn chế việc sử dụng "dynamic" nếu không cần thiết và sử dụng cẩn thận để tránh các lỗi không mong muốn trong quá trình chạy chương trình. Nếu có thể, nên sử dụng kiểu dữ liệu cụ thể như "int", "String", "bool" và các lớp đối tượng đã định nghĩa trong chương trình để tận dụng lợi ích của kiểm tra kiểu tại thời điểm biên dịch. */
  dynamic value;

  value = 10; // Gán một giá trị kiểu int cho biến value.
  print("Value là kiểu: ${value.runtimeType}"); // Kết quả: Value là kiểu: int

  value = "Hello"; // Gán một giá trị kiểu String cho biến value.
  print(
      "Value là kiểu: ${value.runtimeType}"); // Kết quả: Value là kiểu: String

  value = true; // Gán một giá trị kiểu bool cho biến value.
  print("Value là kiểu: ${value.runtimeType}"); // Kết quả: Value là kiểu: bool

/*  Null Safety
Trong Dart, Null safety là một tính năng mới giới thiệu từ phiên bản Dart 2.12. Nó nhằm giúp xử lý vấn đề liên quan đến giá trị null (null values) trong chương trình, giúp giảm thiểu các lỗi liên quan đến null và tăng tính ổn định và an toàn của mã.
Trước khi có Null safety, Dart cho phép mọi biến có thể chứa giá trị null mà không cần khai báo rõ ràng. Điều này dẫn đến việc có thể xảy ra lỗi khi thực hiện các hoạt động trên các biến không kiểm tra null.
Null safety giới thiệu hai loại biến để đảm bảo an toàn:
Non-nullable (không thể null): Được ký hiệu bằng dấu Type, như int, double, String, ... Với loại biến này, bạn cam kết không gán giá trị null vào biến.
Nullable (có thể null): Được ký hiệu bằng dấu Type?, như int?, double?, String?, ... Với loại biến này, bạn có thể gán giá trị null hoặc giá trị của kiểu tương ứng vào biến.
Khi sử dụng Null safety, bạn cần kiểm tra và xử lý các biến có thể null để tránh những lỗi liên quan đến null. Điều này được thực hiện thông qua hai toán tử mới là ! và ?.
!: Toán tử kiểm tra null ("null assertion operator"). Nếu bạn chắc chắn biến không null, bạn có thể sử dụng toán tử ! để bỏ qua cảnh báo của Dart và truy cập vào giá trị của biến.
?: Toán tử kiểm tra null ("null check operator"). Bạn sử dụng toán tử ? để kiểm tra xem biến có null hay không trước khi truy cập vào nó. */
  // Dùng khai báo biến Nullable (có thể null)
  int? num1;
  print('num1: ${num1} - ${num1.runtimeType} ');
  // Dùng ktra giá trị biến
  int? nullableValue = null;
  nullableValue = 102;
  int nonNullableValue = 42;

// Sử dụng null assertion operator
  print(
      nullableValue!); // Nếu nullableValue != null, in ra giá trị của biến. Nếu nullableValue == null, sẽ gây ra lỗi.

// Sử dụng null check operator
  nullableValue = null;
  print(nullableValue
      ?.toString()); // Nếu nullableValue != null, in ra giá trị sau khi chuyển sang chuỗi. Nếu nullableValue == null, không làm gì cả.

// Gán giá trị cho biến nullable
  nullableValue = 10;

/*  LATE
Trong Dart, từ khoá late được sử dụng để xác định rằng một biến không được khởi tạo ngay lập tức, mà sẽ được khởi tạo sau đó trước khi được truy cập lần đầu tiên. Từ khoá late chỉ áp dụng cho các biến instance, tức là biến được khai báo bên trong một lớp.
Khi sử dụng từ khoá late, bạn cam kết rằng biến sẽ được gán giá trị trước khi bạn truy cập vào nó. Nếu không gán giá trị cho biến trước khi truy cập, Dart sẽ báo lỗi khi biên dịch chương trình.
Điểm quan trọng là bạn không thể sử dụng từ khoá late cho các biến static (biến thuộc về lớp, không phải thuộc về mỗi đối tượng cụ thể), và bạn cũng không thể sử dụng nó cho các biến final hoặc const.???
Lưu ý rằng bạn cần chắc chắn rằng bạn đã gán giá trị cho biến late trước khi truy cập vào nó, nếu không, chương trình sẽ gây ra lỗi. Sử dụng từ khoá late khi bạn có đảm bảo rằng biến sẽ được khởi tạo trước khi sử dụng có thể giúp bạn quản lý tốt hơn và tạo mã sạch hơn trong Dart. */

/* FINAL and CONST
https://linhta.dev/blog/final-va-const-trong-dart/#:~:text=const%20phải%20có%20giá%20trị,trị%20với%20object%20ban%20đầu.
  */

// Lưu ý: .runtimeType sẽ return kết quả khác nhau trên các môi trường desktop và web
}
