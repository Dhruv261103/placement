class StatasticModels {
  List<Statastic> statastic;

  StatasticModels({required this.statastic});

  factory StatasticModels.fromJson(Map<String, dynamic> json) =>
      StatasticModels(
        statastic: List<Statastic>.from(
            json["data"].map((x) => Statastic.fromJson(x))),
      );
}

class Statastic {
  String minPack;
  String avgPack;
  String maxPack;
  int year;
  String percentage;

  Statastic({
    required this.minPack,
    required this.avgPack,
    required this.maxPack,
    required this.year,
    required this.percentage,
  });

  factory Statastic.fromJson(Map<String, dynamic> json) => Statastic(
      minPack: json["Min_Pack"],
      avgPack: json["Avg_Pack"],
      maxPack: json["Max_Pack"],
      year: json["Year"],
      percentage: json["Percentage"].toString());
}
