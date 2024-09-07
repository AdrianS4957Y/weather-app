import 'dart:convert';

import 'package:weathers/api/json/city.dart';

import 'package:flutter/services.dart' show rootBundle;

class CityController {
  static List<City> cities = [];
  static loadCities() async {
    // File file = File("./cities-dataset.json");
    // final decodedJson = jsonDecode(file.readAsStringSync());
    final String jsonString =
        await rootBundle.loadString('assets/cities-dataset.json');
    final decodedJson = jsonDecode(jsonString);
    for (dynamic rawCity in decodedJson["results"]) {
      // print(rawCity);
      cities.add(City.fromJson(rawCity));
    }
    return cities;
  }

  static List<City> filter(bool Function(City) checkFunction) {
    return cities.where(checkFunction).toList();
  }

  static List<City> findCitiesByName(String name) {
    name = name.toLowerCase();
    return CityController.filter(
      (city) =>
          city.alternateNames
              .where((c) => c.toLowerCase().contains(name))
              .isNotEmpty ||
          city.asciiName.toLowerCase().contains(name),
    );
  }
}
