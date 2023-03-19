import '../enums/config_type.dart';

class Config {
  final ConfigType type;
  final double value;

  Config({ required this.type, required this.value });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'value': value,
    };
  }
}