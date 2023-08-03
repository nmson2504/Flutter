import 'dart:collection';
import 'dart:ffi';

void main() {
  /* A Queue is a collection that can be manipulated at both ends. One can iterate over the elements of a queue through forEach or with an Iterator. 
   Chú ý rằng Queue là một cấu trúc dữ liệu hàng đợi, nghĩa là phần tử đầu tiên được thêm vào sẽ là phần tử đầu tiên được lấy ra (First-In-First-Out, FIFO). Nếu bạn muốn sử dụng các phép toán như thêm phần tử vào cuối Queue (enqueue) hoặc lấy phần tử ra khỏi đầu Queue (dequeue), bạn có thể sử dụng các phương thức tương ứng của lớp Queue như add, addAll, remove, removeFirst, và nhiều phương thức khác.
   */
  // Khai báo - phải import 'dart:collection';
  var q = Queue(); // tương đương Queue<dynamic>();
  print(
      'q: ${q} - data type: ${q.runtimeType}'); // q: {} - data type: ListQueue<dynamic>
  final q1 = Queue<int>();
  print(
      'q: ${q1} - data type: ${q1.runtimeType}'); // q: {} - data type: ListQueue<int>

  // Khởi tạo values ngay khi khai báo luôn
  Queue<int> myQueue = Queue.from([1, 2, 3, 4, 5]);
  print('myQueue: ${myQueue}');
  // or
  Queue<String> myQueue1 = Queue.of(['mot', 'hai', 'ba', 'bon']);
  print('myQueue1: ${myQueue1}');
  // or - khởi tạo values từ collection cho trước
  List<int> myList = [1, 2, 3, 4, 5];
  Queue<int> myQueue3 = Queue.from([for (var item in myList) item]);
  print('myQueue3: ${myQueue3}');

  // Add
  q.add(100); // Adds [value] at the end of the queue.
  q.add(200); // như .addLast
  print('q.add: $q');
  q.addFirst(1);
  q.addLast(333); // như .add
  print('q.add: $q');
  // add multi values from collection
  q.addAll(myList);
  print(' q.addAll: $q');

  // Read
  print(q.first); // return first - đầu queue
  print(q.last); // return lasr - cuối queue
  print(q.elementAt(3)); // from index
// Dùng vòng lặp for-each để lấy tất cả các giá trị trong Queue
  myQueue.forEach((value) {
    print(value);
  });

// Update
/*để cập nhật giá trị của phần tử trong Queue, bạn cần thực hiện các bước trung gian: chuyển Queue sang List, change values trên List, gán List ngược lại vào Queue  
 */
  Queue<int> myQueue2 = Queue.from([1, 2, 3, 4, 5]);
  // Chuyển Queue thành List để cập nhật
  List<int> myList1 = myQueue2.toList();
  // Cập nhật giá trị của phần tử có index là 2 thành 10
  myList1[2] = 10;
  // Tạo một Queue mới từ List đã cập nhật
  myQueue2 = Queue.from(myList1);
  print(myQueue2); // Kết quả: {1, 2, 10, 4, 5}

  // Delete
  q.remove(1); // như .removeFirst
  print('q.remove: $q');
  q.removeFirst(); // như .remove
  print('q.removeFirst: $q');
  q.removeLast();
  print('q.removeLast: $q');
  // remove theo điều kiện
  q.removeWhere((element) => element < 100);
  print('q.removeWhere: $q');
  q.retainWhere((element) => element > 200); // remove all elements NOT >200
  print('q.retainWhere: $q');
  q.clear(); // delete all

  // Kiểm tra
  print('myQueue2: $myQueue2');

  print('myQueue2.isEmpty: ${myQueue2.isEmpty}');
  print('myQueue2.isEmpty: ${myQueue2.isNotEmpty}');

  print('myQueue2: ${myQueue2.contains(10)}');

  print(' myQueue2.every: ${myQueue2.every((element) => element >= 5)}');
  print(' myQueue2.every: ${myQueue2.any((element) => element >= 5)}');

  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------CASTING------------"); // just to show where the cursor is
// CHUYỂN ĐỔI GIỮA CÁC DATA TYPE LIST - SET - MAP - QUEUE
  List<int> ls_1 = [12, 34, 5, 7, 9, 21, 90];
  List<String> ls_2 = ['a', 'b', 'c', 'd'];
  Set<int> set_1 = {2, 4, 6, 8, 10};
  Set<String> set_2 = {'mot', 'hai', 'ba', 'bon'};
  Map<int, String> map_1 = {1: 'orange', 2: 'apple', 3: 'banana', 4: 'cherry'};
  Map<String, int> map_2 = {
    'orange': 20,
    'apple': 230,
    'banana': 125,
    'cherry': 435
  };
// 1 - Dùng vòng lặp truyền values
  Set<int> kq = {};
  ls_1.forEach((element) {
    kq.add(element);
  });
  print('${kq.runtimeType}   - $kq');

// 2 - Dung method .addAll
  List<String> ls_kq = [];
  ls_kq.addAll(set_2);
  print('${ls_kq.runtimeType}   - $ls_kq');

// 3 - Dung method .from
  List<int> ls_kq1 = [];
  ls_kq1 = List.from(set_1);
  print('${ls_kq1.runtimeType}   - $ls_kq1');

  var qu_1 = Queue();
  qu_1 = Queue.from(set_2);
  print('${qu_1.runtimeType}   - $qu_1');

  Set<dynamic> ss = {};
  ss = Set.from(ls_1);
  print('\n${ss.runtimeType}   - $ss');

// 4 - Dung method .map
/* Casc method .toList(), .toSet() return ve kieu String 
--> object nhan ket qua phai co data type <String> or <dynamic>
*/
  Set<dynamic> set_kq = ls_1.map((e) {
    return '$e';
  }).toSet();
  print('${set_kq.runtimeType}   - $set_kq');

  List<dynamic> ls_kk = set_2.map((e) {
    return e;
  }).toList();
  print('${ls_kk.runtimeType}   - $ls_kk');

// 5 - Dung toList(), toSet() truc tiep
  Set<dynamic> s_kq = ls_2.toSet();
  print('s_kq: ${s_kq}');

  List<dynamic> ls_01 = set_2.toList();
  print('ls_01: ${ls_01}');

// Chuyển đổi List thành Map dung method asMap() - return Map<int, String>
/* 
Sử dụng asMap() để tạo một Map mới từ List, trong đó các chỉ số của List trở thành keys của Map và giá trị tương ứng trở thành values. */
  Map<int, String> map_k = ls_2.asMap();
  print('map_k: ${map_k}');

// Map to List: return values of elements
  Map<String, int> myMap = {'apple': 1, 'banana': 2, 'orange': 3};
  List<int> mList = myMap.values.toList();
  print('mList: ${mList}'); // return [1,2,3]
  // Map to Set
  Map<String, int> mMap = {'apple': 1, 'banana': 2, 'orange': 3};
  Set<String> mySet = mMap.keys.toSet(); // mySet: {apple, banana, orange}
  print('mySet: ${mySet}');

  Set<int> mySet2 = mMap.values.toSet(); // mySet: {1, 2, 3}
  print('mySet: $mySet2');
// Map to Queue
  Map<String, int> myMap1 = {'apple': 1, 'banana': 2, 'orange': 3};
  Queue<String> myQueue02 =
      Queue.from(myMap1.keys); // myQueue02: {apple, banana, orange}
  print('myQueue02: ${myQueue02}');
}
