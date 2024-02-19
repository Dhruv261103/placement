import 'dart:convert';

CompanyModels companymodelFromJson(String str) =>
    CompanyModels.fromJson(json.decode(str));

class CompanyModels {
  List<Company> companies;

  CompanyModels({required this.companies});

  factory CompanyModels.fromJson(Map<String, dynamic> json) => CompanyModels(
        companies:
            List<Company>.from(json["data"].map((x) => Company.fromJson(x))),
      );
}

class Company {
  String companyName;
  String year;

  Company({required this.companyName, required this.year});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyName: json["Company_Name"],
        year: json["Year"].toString(),
      );
}
