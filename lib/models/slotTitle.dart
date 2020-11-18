class SlotTitle {
  String title;
  List slots;

  SlotTitle({this.title, this.slots});

  SlotTitle.fromJson(parsedJson) {
    this.title = parsedJson['title'];
    this.slots = parsedJson['Slots'];
  }
}
