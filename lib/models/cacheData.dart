class CustomModel {
  String id;
  String name;
  String address;
  String logo;

  CustomModel({this.id, this.name, this.address, this.logo});

  factory CustomModel.fromJson(Map<String, dynamic> json) {
    return CustomModel(
        id: json["id"], name: json["name"], address: json["address"], logo: json["logo"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "address": address,"logo": logo };

  @override
  String toString() {
    return "id: $id, name: $name,address: $address,logo: $logo";
  }
}
