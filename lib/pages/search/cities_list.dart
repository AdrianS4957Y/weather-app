import 'package:flutter/material.dart';
import 'package:weathers/api/json/city.dart';
import 'package:weathers/api/weather.dart';
import 'package:weathers/pages/loading/loading.dart';
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

List<Widget> createList(List<City> list, BuildContext context) {
  return list
      .map((city) => CityListItem(
          city: city,
          onClick: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Loading(city: city)));
          }))
      .toList();
}

class CitiesListState extends State<CitiesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 15 / 471),
      child: Column(
        children: createList(Weather.searchCity(widget.searchText), context),
      ),
    );
  }
}
