// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  String username;
  String email;
  String password;
  String phone;
  String image;

  UserData({
    this.id = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.image = '',
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        password: json["Password"] ?? '',
        phone: json["phone"] ??'',
        image: json["image"]?? '',
      );

  //Si no quieres agregar un dato al firebase commenta el dato
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        //"password": password,
        "phone": phone,
      };
}
