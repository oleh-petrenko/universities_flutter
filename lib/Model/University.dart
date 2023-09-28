class UniversityModel {
  UniversityModel(this.universities);
  final List<University> universities;

  factory UniversityModel.fromJson(List<dynamic> json) {
    List<University> uniList = json.map((item) =>
        University.fromJson(item)).toList();
    return UniversityModel(uniList);
  }
}

class University {
  final List<String> webPages;
  final String alphaTwoCode;
  final String country;
  final String name;
  final String? stateProvince;
  final List<String> domains;

  String get displayableTitle {
    return "Country: $country, code: $alphaTwoCode, name: $name";
  }
  String get displayableSubtitle {
    return webPages[0];
  }

  University({
    required this.webPages,
    required this.alphaTwoCode,
    required this.country,
    required this.name,
    this.stateProvince,
    required this.domains,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      webPages: List<String>.from(json['web_pages']),
      alphaTwoCode: json['alpha_two_code'],
      country: json['country'],
      name: json['name'],
      stateProvince: json['state-province'],
      domains: List<String>.from(json['domains']),
    );
  }
}
