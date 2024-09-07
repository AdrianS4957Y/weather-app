import 'package:flutter/material.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weathers/api/json/city.dart';
import 'package:weathers/globals/fonts.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/globals/routes.dart';
import 'package:weathers/pages/7-days/next_7_days.dart';
import 'package:weathers/pages/city_weather/city_name.dart';
import 'package:weathers/pages/city_weather/current_day_weather.dart';
import 'package:weathers/pages/city_weather/enum_selected_days.dart';
import 'package:weathers/pages/city_weather/sky_status.dart';
import 'package:weathers/pages/city_weather/weather_status_list_item.dart';

class CityWeather extends StatefulWidget {
  final Map<dynamic, ParameterValues> dailyWeather;
  final Map<dynamic, ParameterValues> hourlyWeather;
  final Map<dynamic, ParameterValue> currentWeather;
  final City city;
  const CityWeather({
    super.key,
    required this.currentWeather,
    required this.dailyWeather,
    required this.city,
    required this.hourlyWeather,
  });

  @override
  State<CityWeather> createState() => _CityWeatherState();
}

class _CityWeatherState extends State<CityWeather> {
  ESelectedDays selectedDay = ESelectedDays.today;
  TextStyle selectedTextStyle = Fonts.inter(
    color: const Color(0xFF313341),
    fontSize: 8,
  );
  TextStyle unSelectedTextStyle = Fonts.inter(
    color: const Color(0xFFD6996B),
    fontSize: 8,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: backgroundGradient,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 48 / 417,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTapDown: (details) {
                    Navigator.pushNamed(context, Routes.search);
                  },
                  child: Image.asset(
                    "assets/search_icon.png",
                    height: MediaQuery.of(context).size.height * 24 / 417,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 13 / 417,
            ),
            CityName(city: widget.city),
            SkyStatus(currentWeather: widget.currentWeather),
            Column(
              children: [
                WeatherStatusListItem(
                  status: [
                    "RainFall",
                    "${widget.currentWeather[WeatherCurrent.rain]!.value.round()}${widget.currentWeather[WeatherCurrent.rain]!.unit}"
                  ],
                  path: "assets/states/rainfall.svg",
                ),
                WeatherStatusListItem(
                  status: [
                    "Wind",
                    "${widget.currentWeather[WeatherCurrent.wind_speed_10m]!.value.round()}${widget.currentWeather[WeatherCurrent.wind_speed_10m]!.unit}"
                  ],
                  path: "assets/states/wind.svg",
                ),
                WeatherStatusListItem(
                  status: [
                    "Humidity",
                    "${widget.currentWeather[WeatherCurrent.relative_humidity_2m]!.value.round()}${widget.currentWeather[WeatherCurrent.relative_humidity_2m]!.unit}"
                  ],
                  path: "assets/states/humidity.svg",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (selectedDay != ESelectedDays.today) {
                                selectedDay = ESelectedDays.today;
                              }
                            });
                          },
                          child: Text(
                            "Today",
                            style: selectedDay == ESelectedDays.today
                                ? selectedTextStyle
                                : unSelectedTextStyle,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (selectedDay != ESelectedDays.tomorrow) {
                                selectedDay = ESelectedDays.tomorrow;
                              }
                            });
                          },
                          child: Text(
                            "Tomorrow",
                            style: selectedDay == ESelectedDays.tomorrow
                                ? selectedTextStyle
                                : unSelectedTextStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Next7Days(
                                  dailyWeather: widget.dailyWeather,
                                  hourlyCloudCover: widget.hourlyWeather[
                                      WeatherHourly.cloud_cover]!,
                                  hourlyHumidity: widget.hourlyWeather[
                                      WeatherHourly.relative_humidity_2m]!,
                                  hourlySnowfall: widget
                                      .hourlyWeather[WeatherHourly.snowfall]!,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Next 7 Days",
                            style: unSelectedTextStyle,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: const Color(0xFFD6996B),
                          size: MediaQuery.of(context).size.width * 6 / 218,
                        ),
                      ],
                    ),
                  ],
                ),
                CurrentDayWeather(
                  hourlyWeather: widget.hourlyWeather,
                  selectedDay: selectedDay,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
