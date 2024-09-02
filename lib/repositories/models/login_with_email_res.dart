import 'dart:convert';

class LoginWithEmailRes {
  final String message;
  final String accessToken;
  final String expiresIn;

  LoginWithEmailRes({
    required this.message,
    required this.accessToken,
    required this.expiresIn,
  });

  factory LoginWithEmailRes.fromRawJson(String str) =>
      LoginWithEmailRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginWithEmailRes.fromJson(Map<String, dynamic> json) =>
      LoginWithEmailRes(
        message: json["message"] ?? "",
        accessToken: json["accessToken"] ?? "",
        expiresIn: json["expiresIn"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "expiresIn": expiresIn,
      };
}
