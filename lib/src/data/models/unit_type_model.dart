import 'package:get/get.dart';
import '../../../generated/locales.g.dart';

class UnitTypeModel {
  final String id;
  final String name;
  final String code;
  final int index;

  UnitTypeModel({required this.id, required this.name, required this.code, required this.index});

  String get localeName {
    switch (code) {
      case 'tennis':
        return LocaleKeys.tennis.tr;
      case 'basketball':
        return LocaleKeys.basketball.tr;
      case 'football':
        return LocaleKeys.football.tr;
      case 'table_tennis':
        return LocaleKeys.table_tennis.tr;
      case 'badminton':
        return LocaleKeys.badminton.tr;
      default:
        return name;
    }
  }

  factory UnitTypeModel.fromJson(Map<String, dynamic> json) {
    return UnitTypeModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      index: json['index'],
    );
  }
}
