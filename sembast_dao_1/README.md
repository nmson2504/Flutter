# sembast_dao_1

Mô hình DAO (Data Access Object) là một thiết kế mẫu phần mềm (design pattern) được sử dụng để tách biệt logic truy cập dữ liệu khỏi logic xử lý nghiệp vụ trong một ứng dụng. DAO cung cấp một cách tiếp cận tổ chức để quản lý việc truy xuất, lưu trữ, và cập nhật dữ liệu, đồng thời giữ cho các phần khác của ứng dụng không bị ràng buộc với cách dữ liệu được lưu trữ hoặc truy xuất.

Các Thành Phần Chính Của DAO
DAO Interface: Định nghĩa các phương thức mà DAO cần thực hiện, chẳng hạn như các phương thức thêm, xóa, sửa và truy xuất dữ liệu. DAO Interface không chứa bất kỳ logic nào về cách các phương thức đó hoạt động, chỉ định nghĩa các phương thức cần thiết.

DAO Implementation: Cung cấp triển khai thực tế của DAO Interface. Đây là nơi chứa các đoạn mã thực sự thực hiện việc truy xuất dữ liệu từ nguồn dữ liệu (ví dụ: cơ sở dữ liệu, API, file).

Model (Entity): Là các lớp đại diện cho các đối tượng dữ liệu mà DAO sẽ thao tác. Các lớp này thường chứa các thuộc tính và phương thức cần thiết để đại diện cho dữ liệu.

Data Source: Đây là nơi dữ liệu được lưu trữ và quản lý, chẳng hạn như cơ sở dữ liệu SQL, NoSQL, hệ thống tập tin, hoặc dịch vụ web.

# Tổ chức file

[comment]: <> (``` danh dau code block - view sho ra y chang)
[//]: # (This may be the most platform independent comment)

```
D:\SON\FLUTTER\SEMBAST_DAO_1\LIB
|  
|   main.dart
|   
+---dao
|       dao_impl.dart - class UserDaoImpl implements - UserDaoDAO Implementation
|       user_dao.dart - abstract class UserDao - DAO Interface 
|       
+---models
|       user.dart - class User 
|       
\---services
        db_service.dart - Data Source - class DatabaseService (databaseFactoryIo.openDatabase)
        user_service.dart - class UserService (generateRandomUser)
```

# Chức năng:

+ Add: 
+ Select: qua checkbox, select all, select update DB & not update DB
+ Delete: qua select
+ Count: tổng số items, số select
+ Update, Delete trên từng dòng item

Làm thêm: 

        - Update
        - Delete qua thao tác vuốt