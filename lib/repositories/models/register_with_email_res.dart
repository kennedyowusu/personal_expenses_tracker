import 'dart:convert';

class RegisterWithEmailRes {
  final String? message;

  RegisterWithEmailRes({
    this.message,
  });

  factory RegisterWithEmailRes.fromRawJson(String str) =>
      RegisterWithEmailRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterWithEmailRes.fromJson(Map<String, dynamic> json) =>
      RegisterWithEmailRes(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
