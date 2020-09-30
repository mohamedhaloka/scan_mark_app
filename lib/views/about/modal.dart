// To parse this JSON data, do
//
//     final aboutUsModal = aboutUsModalFromJson(jsonString);

import 'dart:convert';

AboutUsModal aboutUsModalFromJson(String str) => AboutUsModal.fromJson(json.decode(str));

String aboutUsModalToJson(AboutUsModal data) => json.encode(data.toJson());

class AboutUsModal {
  AboutUsModal({
    this.content,
  });

  String content;

  factory AboutUsModal.fromJson(Map<String, dynamic> json) => AboutUsModal(
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
  };
}
