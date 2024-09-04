import "package:http/http.dart" as http;
import 'package:html/parser.dart';
import 'package:weathers/api/database.dart';

Map<String, String> listOfCountries = countries;
Map<String, String> _HEADERS = {
  "Host": "world-weather.ru",
  "Accept":
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
  "Accept-Language": "ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3",
  "Accept-Encoding": "gzip, deflate, br",
  "Upgrade-Insecure-Requests": "1",
  "Sec-Fetch-Dest": "document",
  "Sec-Fetch-Mode": "navigate",
  "Sec-Fetch-Site": "none",
  "Sec-Fetch-User": "?1",
  "Connection": "keep-alive",
};

class Weather {
  late String uri;
  Weather({this.uri = "world-weather.ru", headers}) {
    _HEADERS = headers ?? _HEADERS;
  }
  _loadCountriesName() async {
    dynamic htmlPage =
        await http.get(Uri.https(uri, "/pogoda"), headers: _HEADERS);
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
          headers: _HEADERS);
    }
    final parsedHTML = parse(rawPage);
    parsedHTML.querySelectorAll("a.tooltip").forEach((e) {
      output[e.innerHtml] = e.attributes["href"].toString();
    });
    return output;
  }
}
