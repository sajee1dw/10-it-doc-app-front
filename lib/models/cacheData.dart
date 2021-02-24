class CustomModel {
  String id;
  String name;
  String shortAddress;
  String logo;

  CustomModel({this.id, this.name, this.shortAddress, this.logo});

  factory CustomModel.fromJson(Map<String, dynamic> json) {
    return CustomModel(
        id: json["id"],
        name: json["name"],
        shortAddress: json["shortAddress"],
        logo: json["logo"]);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "shortAddress": shortAddress, "logo": logo};

  @override
  String toString() {
    return "id: $id, name: $name,shortAddress: $shortAddress,logo: $logo";
  }
}
