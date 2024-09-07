import 'package:weathers/api/json/coordinates.dart';

class City {
  final String id;
  final String name;
  final String timezone;
  final Coordinates coordinates;
  final String asciiName;
  final String labelEn;
  final String countryCode;
  final String countryName;
  final List<String> alternateNames;

  City({
    required this.id,
    required this.name,
    required this.timezone,
    required this.coordinates,
    required this.asciiName,
    required this.alternateNames,
    required this.countryCode,
    required this.countryName,
    required this.labelEn,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['geoname_id'],
      name: json['name'],
      timezone: json['timezone'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      asciiName: json['ascii_name'],
      alternateNames: json['alternate_names'] != null
          ? List<String>.from(json['alternate_names'])
          : [],
      countryCode: json['country_code'],
      countryName: json['cou_name_en'],
      labelEn: json['label_en'],
    );
  }
}
