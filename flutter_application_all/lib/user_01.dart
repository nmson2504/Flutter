import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user_01.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class User01 {
  // Với chú thích này, thuộc tính address of object trong Dart sẽ được ánh xạ sang key diachi trong JSON string.
  @JsonKey(name: 'diachi')
  late String address;
//  thuộc tính được đánh dấu là required và nếu key đó không tồn tại trong JSON khi deserialize, sẽ báo lỗi key thiếu sẽ .
// nếu ko có chú thích này mà truyền thiếu thuộc tính vẫn báo lỗi nhưng chung chung khó hiểu, có chú thích sẽ báo cụ thể là thiếu key nào
  @JsonKey(required: true)
  String email;
// Nếu một khóa JSON không tồn tại, thuộc tính trong Dart sẽ được đặt giá trị mặc định.
  @JsonKey(defaultValue: 'Unknown')
  String name;
  User01(this.name, this.email, this.address);
  /* 
  một số chú thích khác:
  -  Bỏ qua thuộc tính khi serialize và deserialize.
    @JsonKey(ignore: true)
    String internalId;
  - includeIfNull: Xác định liệu khóa có được bao gồm trong JSON khi giá trị của nó là null hay không(mặc định là false)
    @JsonKey(includeIfNull: false)
    String? middleName;
  - Cung cấp các hàm riêng để chuyển đổi giữa giá trị JSON và giá trị trong Dart.
    @JsonKey(fromJson: _fromEpoch, toJson: _toEpoch)
    static DateTime _fromEpoch(int epoch) => DateTime.fromMillisecondsSinceEpoch(epoch);
    static int _toEpoch(DateTime date) => date.millisecondsSinceEpoch;

   */

  // String name;
  // String email;
  // String address;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User01.fromJson(Map<String, dynamic> json) => _$User01FromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$User01ToJson(this);

  // Override the toString() method to print all properties
  @override
  String toString() {
    return 'User01{name: $name, email: $email, address: $address}';
  }
}
