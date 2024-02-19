import 'package:meta/meta.dart';
import 'dart:convert';

PostModels postModelsFromJson(String str) =>
    PostModels.fromJson(json.decode(str));

class PostModels {
  List<Placement> placement;

  PostModels({
    required this.placement,
  });

  factory PostModels.fromJson(Map<String, dynamic> json) => PostModels(
        placement: List<Placement>.from(
            json["data"].map((x) => Placement.fromJson(x))),
      );
}

class Placement {
  String idNo;
  String firstName;
  String middleName;
  String lastName;
  String? company;
  String yaer;

  Placement({
    required this.idNo,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.company,
    required this.yaer,
  });

  factory Placement.fromJson(Map<String, dynamic> json) => Placement(
      idNo: json["Id_No"],
      company: json["Company"],
      firstName: json["First_Name"],
      lastName: json["Last_Name"],
      middleName: json["Middle_Name"],
      yaer: json["Yaer"].toString());
}
