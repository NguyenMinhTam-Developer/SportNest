class UnitTypeModel {
  final String id;
  final String name;
  final String code;
  final int index;

  UnitTypeModel({required this.id, required this.name, required this.code, required this.index});

  factory UnitTypeModel.fromJson(Map<String, dynamic> json) {
    return UnitTypeModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      index: json['index'],
    );
  }
}
