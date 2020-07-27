class Info {
  String docName;
  String docAddress;

  Info({
    this.docName,
    this.docAddress,
  });

  Info.fromJson(Map<String, dynamic> parsedJson) {
    this.docName = parsedJson['name'];
    this.docAddress = parsedJson['address'];
  }
}
