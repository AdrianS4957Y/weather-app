// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weathers/pages/city_weather/current_day_weather_list_item.dart';
import 'package:weathers/pages/city_weather/enum_selected_days.dart';
import 'package:weathers/pages/city_weather/sky_status.dart';

class CurrentDayWeather extends StatefulWidget {
  final ESelectedDays selectedDay;
  final Map<dynamic, ParameterValues> hourlyWeather;
  const CurrentDayWeather({
    super.key,
    required this.hourlyWeather,
    this.selectedDay = ESelectedDays.today,
  });

  @override
  CurrentDayWeatherState createState() => CurrentDayWeatherState();
}

class CurrentDayWeatherState extends State<CurrentDayWeather> {
  @override
  Widget build(BuildContext context) {
    DateTime startOfTheDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now()
          .add(Duration(
              days: (widget.selectedDay == ESelectedDays.tomorrow ? 1 : 0)))
          .day,
    );
    List<Widget> list = [];
    for (DateTime day = startOfTheDay.add(Duration(minutes: 30)),
            targetTime = DateTime(startOfTheDay.year, startOfTheDay.month,
                startOfTheDay.add(const Duration(days: 1)).day, 0, 30);
        day.isBefore(targetTime);
        day = day.add(const Duration(hours: 1))) {
      dynamic cloudCover =
              widget.hourlyWeather[WeatherHourly.cloud_cover]?.values[day],
          snowfall = widget.hourlyWeather[WeatherHourly.snowfall]?.values[day],
          rain = widget.hourlyWeather[WeatherHourly.rain]?.values[day],
          windSpeed =
              widget.hourlyWeather[WeatherHourly.wind_speed_10m]?.values[day],
          isDay = widget.hourlyWeather[WeatherHourly.is_day]?.values[day];

      String path = skyStatePathGenerator(
          cloudCover: cloudCover,
          isDay: isDay,
          rain: rain,
          snowFall: snowfall,
          windSpeed: windSpeed);
      list.add(CurrentDayWeatherListItem(
        hour: day.hour,
        path: path,
        temperature: widget
                .hourlyWeather[WeatherHourly.apparent_temperature]!.values[day]
                ?.round() ??
            30,
      ));
    }
    ScrollController controller = ScrollController();
    return
        //  Scrollbar(
        //   thumbVisibility: true,
        //   controller: controller,
        //   thickness: 3,
        //   radius: Radius.circular(4),
        //   scrollbarOrientation: ScrollbarOrientation.top,
        //   child:
        //   ),
        SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          // vertical: MediaQuery.of(context).size.height * 16 / 417,
          ),
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(children: list),
    );
  }
}
