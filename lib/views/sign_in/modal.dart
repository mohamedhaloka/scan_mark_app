// To parse this JSON data, do
//
//     final userDataModal = userDataModalFromJson(jsonString);

import 'dart:convert';

UserDataModal userDataModalFromJson(String str) => UserDataModal.fromJson(json.decode(str));

String userDataModalToJson(UserDataModal data) => json.encode(data.toJson());

class UserDataModal {
  UserDataModal({
    this.userEmail,
    this.userName,
    this.userPass,
    this.userPhoto,
  });

  String userEmail;
  String userName;
  String userPass;
  String userPhoto;

  factory UserDataModal.fromJson(Map<String, dynamic> json) => UserDataModal(
    userEmail: json["user email"],
    userName: json["user name"],
    userPass: json["user pass"],
    userPhoto: json["user photo"],
  );

  Map<String, dynamic> toJson() => {
    "user email": userEmail,
    "user name": userName,
    "user pass": userPass,
    "user photo": userPhoto,
  };
}
