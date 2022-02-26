class DemoModel{
  String name;//Default Constructor :D

  DemoModel();

  //To convert the details from DocumentSnapshot into Ledger object
  DemoModel.fromDocumentSnapshot(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> convertToMap(DemoModel item) {
    Map<String, dynamic> regionData = new Map<String, dynamic>();
    regionData['name'] = item.name;
    return regionData;
  }
}