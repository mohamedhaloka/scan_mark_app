// To parse this JSON data, do
//
//     final userDataModal = userDataModalFromJson(jsonString);

import 'dart:convert';

UserDataModal userDataModalFromJson(String str) => UserDataModal.fromJson(json.decode(str));

String userDataModalToJson(UserDataModal data) => json.encode(data.toJson());

class UserDataModal {
  UserDataModal({
    this.userAddress,
    this.userEmail,
    this.userName,
    this.userPass,
    this.userPhone,
    this.userPhoto,
  });

  String userAddress;
  String userEmail;
  String userName;
  String userPass;
  String userPhone;
  String userPhoto;

  factory UserDataModal.fromJson(Map<String, dynamic> json) => UserDataModal(
    userAddress: json["user address"],
    userEmail: json["user email"],
    userName: json["user name"],
    userPass: json["user pass"],
    userPhone: json["user phone"],
    userPhoto: json["user photo"],
  );

  Map<String, dynamic> toJson() => {
    "user address": userAddress,
    "user email": userEmail,
    "user name": userName,
    "user pass": userPass,
    "user phone": userPhone,
    "user photo": userPhoto,
  };
}
