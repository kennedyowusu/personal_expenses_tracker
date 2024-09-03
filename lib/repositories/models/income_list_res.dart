import 'dart:convert';

class IncomeListRes {
  final List<Income>? data;

  IncomeListRes({
    this.data,
  });

  factory IncomeListRes.fromRawJson(String str) =>
      IncomeListRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IncomeListRes.fromJson(Map<String, dynamic> json) => IncomeListRes(
        data: json["data"] == null
            ? []
            : List<Income>.from(json["data"]!.map((x) => Income.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Income {
  final String? id;
  final String? nameOfRevenue;
  final num? amount;

  Income({
    this.id,
    this.nameOfRevenue,
    this.amount,
  });

  factory Income.fromRawJson(String str) => Income.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json["id"],
        nameOfRevenue: json["nameOfRevenue"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameOfRevenue": nameOfRevenue,
        "amount": amount,
      };
}
