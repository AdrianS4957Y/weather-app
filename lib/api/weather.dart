import "package:http/http.dart" as http;
import 'package:html/parser.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weathers/api/database.dart';
import 'package:logging/logging.dart';
import 'package:weathers/api/json/city.dart';
import 'package:weathers/api/json/city_controller.dart';

Map<String, String> listOfCountries = countries;
Logger logger = Logger("API");
const weather = WeatherApi();

class Weather {
  late String uri;
  Weather({this.uri = "world-weather.ru"});
  _loadCountriesName() async {
    dynamic htmlPage = await http.get(
      Uri.https(uri, "/pogoda"),
    );
    final parsedHTML = parse(htmlPage);
    parsedHTML.querySelectorAll("li.country-block>a").forEach(
          (e) => listOfCountries[e.innerHtml] = e.attributes["href"].toString(),
        );
  }

  static Map<String, String> getCountryByName(String name) {
    return Map.fromEntries(listOfCountries.entries
        .where((e) => e.key.toLowerCase().contains(name.toLowerCase())));
  }

  static Future<Map<String, String>> getCitiesByCountry(String country) async {
    Map<String, String> output = {};
    dynamic rawPage;
    if (countries[country] == null) {
      return {};
    } else {
      rawPage = await http.get(
        Uri.https(countries[country]!.replaceFirst("//", "")),
      );
    }
    final parsedHTML = parse(rawPage);
    parsedHTML.querySelectorAll("a.tooltip").forEach((e) {
      output[e.innerHtml] = e.attributes["href"].toString();
    });
    return output;
  }

  static Future<Map<String, String>> _searchCity(String name) async {
    if (name.isEmpty) {
      return Future(() {
        return {};
      });
    }
    Map<String, String> map = {};
    dynamic response = await http
        .post(Uri.https("world-weather.ru", "/search"), body: {"city": name});
    final parsedHTML = parse(response.body);
    final listOfLinks = parsedHTML.querySelectorAll("a").where((element) =>
        element.attributes["href"] != null &&
        element.attributes["href"]!.contains("//world-weather.ru/pogoda/") &&
        element.attributes["href"] != "//world-weather.ru/pogoda/");
    logger.info(listOfLinks);
    for (var e in listOfLinks) {
      map[e.text] = e.attributes["href"]!.replaceAll("//", "/");
    }
    logger.info(map);
    return map;
  }

  static List<City> searchCity(String name) {
    if (CityController.cities.isEmpty) {
      CityController.loadCities();
    }
    if (name.isEmpty) {
      return CityController.cities;
    }
    return CityController.findCitiesByName(name);
  }

  static Future<ApiResponse> getWeather(City city) async {
    const weather = WeatherApi();
    ApiResponse response = await weather.request(
      latitude: city.coordinates.lat,
      longitude: city.coordinates.lon,
      daily: {
        WeatherDaily.apparent_temperature_max,
        WeatherDaily.rain_sum,
        WeatherDaily.wind_speed_10m_max,
        WeatherDaily.showers_sum,
        WeatherDaily.sunrise,
        WeatherDaily.sunset
      },
      current: {
        WeatherCurrent.cloud_cover,
        WeatherCurrent.is_day,
        WeatherCurrent.rain,
        WeatherCurrent.relative_humidity_2m,
        WeatherCurrent.snowfall,
        WeatherCurrent.surface_pressure,
        WeatherCurrent.wind_speed_10m,
        WeatherCurrent.apparent_temperature
      },
      hourly: {
        WeatherHourly.apparent_temperature,
        WeatherHourly.rain,
        WeatherHourly.cloud_cover,
        WeatherHourly.is_day,
        WeatherHourly.snowfall,
        WeatherHourly.relative_humidity_2m,
      },
      forecastDays: 8,
      // startDate: DateTime.now(),
      // endDate: DateTime.now().add(const Duration(days: 7)),
    );
    return response;
  }
}
