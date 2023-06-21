// class ShopLoginModel {
//   bool? status;
//   String? message;
//   UserData? data;
//
//   ShopLoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? UserData.fromJson(json['data']) : null;
//   }
// }
//
// class UserData {
//   int? id;
//   String? name;
//   String? phone;
//   String? image;
//   int? points;
//   int? credit;
//   String? email;
//   String? token;
//
//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     points = json['points'];
//     credit = json['credit'];
//     token = json['token'];
//   }
// }
class LoginModel {
  String? name;
  String? email;
  String? mobile;
  // List<Null>? img;
  String? id;
  dynamic status;
  String? token;
  int? statusCode;
  String? msg;
  String? role;
  bool? IsAdmin;

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    statusCode = json['statusCode'];
    msg = json['msg'];
    role = json['role'];
    IsAdmin = json['IsAdmin'];
    // if (json['img'] != null) {
    //   img = <Null>[];
    //   json['img'].forEach((v) {
    //     img!.add(new Null.fromJson(v));
    //   });
    // }
    id = json['id'];
    status = json['status'];
    token = json['token'];
  }

}
