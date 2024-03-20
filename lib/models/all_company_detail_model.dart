class AllCompanyDetail {
  List<AllCompany> allcompany;

  AllCompanyDetail({required this.allcompany});

  factory AllCompanyDetail.fromJson(Map<String, dynamic> json) =>
      AllCompanyDetail(
        allcompany: List<AllCompany>.from(
            json["data"].map((x) => AllCompany.fromJson(x))),
      );
}

class AllCompany {
  String name;
  String subtype;
  String bound;
  String package;
  String perroundcentage;
  int totalitstu;

  AllCompany({
    required this.name,
    required this.subtype,
    required this.bound,
    required this.package,
    required this.perroundcentage,
    required this.totalitstu,
  });

  factory AllCompany.fromJson(Map<String, dynamic> json) => AllCompany(
        name: json["name"],
        subtype: json["subtype"],
        bound: json["bound"],
        package: json["package"],
        perroundcentage: json["round"],
        totalitstu: json["total_it_stu"],
      );
}
