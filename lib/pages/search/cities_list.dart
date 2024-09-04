import 'package:flutter/material.dart';
import 'package:weathers/api/weather.dart';
import 'package:weathers/pages/search/city_list_item.dart';

class CitiesList extends StatefulWidget {
  final String searchText;
  const CitiesList({
    super.key,
    required this.searchText,
  });

  @override
  CitiesListState createState() => CitiesListState();
}

List<Widget> createListSync(
    Map<String, String> map, MapEntry<String, String> city) {
  List<MapEntry<String, String>> castedMap = map.entries.toList();
  List<Widget> list = castedMap
      .map((entry) => CityListItem(
          cityName: entry.key,
          onClick: () {
            city = entry;
          }))
      .toList();
  return list;
}

List<Widget> createList(
    Future<Map<String, String>> map, MapEntry<String, String> city) {
  List<MapEntry<String, String>> castedMap = [];
  map.then((value) {
    castedMap = value.entries.toList();
  }).catchError((error) {
    throw error;
  });
  List<Widget> list = castedMap
      .map((entry) => CityListItem(
          cityName: entry.key,
          onClick: () {
            city = entry;
          }))
      .toList();
  return list;
}

class CitiesListState extends State<CitiesList> {
  MapEntry<String, String> city = const MapEntry("", "");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 15 / 471),
      child: Column(
        children:
            createList(Weather.getCitiesByCountry(widget.searchText), city),
      ),
    );
  }
}
