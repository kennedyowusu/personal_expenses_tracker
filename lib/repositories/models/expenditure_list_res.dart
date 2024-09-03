import 'dart:convert';

class ExpenditureListRes {
  final List<Expenditure>? data;

  ExpenditureListRes({
    this.data,
  });

  factory ExpenditureListRes.fromRawJson(String str) =>
      ExpenditureListRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenditureListRes.fromJson(Map<String, dynamic> json) =>
      ExpenditureListRes(
        data: json["data"] == null
            ? []
            : List<Expenditure>.from(
                json["data"]!.map((x) => Expenditure.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Expenditure {
  final String? id;
  final String? category;
  final num? estimatedAmount;
  final String? nameOfItem;

  Expenditure({
    this.id,
    this.category,
    this.estimatedAmount,
    this.nameOfItem,
  });

  factory Expenditure.fromRawJson(String str) =>
      Expenditure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Expenditure.fromJson(Map<String, dynamic> json) => Expenditure(
        id: json["id"],
        category: json["category"],
        estimatedAmount: json["estimatedAmount"],
        nameOfItem: json["nameOfItem"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "estimatedAmount": estimatedAmount,
        "nameOfItem": nameOfItem,
      };
}
