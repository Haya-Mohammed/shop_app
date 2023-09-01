class LoginModel {
  late bool status;
  late String message;
  late UserModel? data;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

}

class UserModel {
   late int id;
   late String name;
   late String email;
   late String phone;
   late String image;
   late int points;
   late int credit;
   late String token;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
