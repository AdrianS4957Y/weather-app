import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weathers/globals/fonts.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/pages/7-days/one_day_weather.dart';
import 'package:weathers/pages/city_weather/sky_status.dart';

class Next7Days extends StatefulWidget {
  final Map<dynamic, ParameterValues> dailyWeather;
  final ParameterValues hourlyCloudCover;
  final ParameterValues hourlyHumidity;
  final ParameterValues hourlySnowfall;
  const Next7Days({
    super.key,
    required this.dailyWeather,
    required this.hourlyCloudCover,
    required this.hourlyHumidity,
    required this.hourlySnowfall,
  });

  @override
  Next7DaysState createState() => Next7DaysState();
}

getSumOfDay(Map<DateTime, dynamic> values, DateTime day) {
  num value = 0;
  for (DateTime currentDay = DateTime(day.year, day.month, day.day, 0, 30),
          end = currentDay.add(const Duration(days: 1));
      currentDay.isBefore(end);
      currentDay = currentDay.add(const Duration(hours: 1))) {
    value += (values[currentDay] ?? 0);
  }
  return value;
}

class Next7DaysState extends State<Next7Days> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 0, 30);
    const aDay = Duration(days: 1);
    String path = skyStatePathGenerator(
      isDay: 1,
      rain: widget.dailyWeather[WeatherDaily.rain_sum]?.values[now.add(
        aDay,
      )],
      windSpeed:
          widget.dailyWeather[WeatherDaily.wind_speed_10m_max]?.values[now.add(
        aDay,
      )],
      cloudCover: getSumOfDay(
            widget.hourlyCloudCover.values,
            now.add(
              aDay,
            ),
          ) /
          24,
      snowFall: getSumOfDay(
        widget.hourlySnowfall.values,
        now.add(
          aDay,
        ),
      ),
    );
    List<Widget> the6Days = [];
    for (DateTime day = today.add(const Duration(days: 2)),
            end = today.add(const Duration(days: 8));
        day.isBefore(end);
        day = day.add(aDay)) {
      the6Days.add(OneDayWeather(
          path: skyStatePathGenerator(),
          temperature: widget
              .dailyWeather[WeatherDaily.apparent_temperature_max]!.values[day]!
              .round(),
          day: day));
    }
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Next 7 days",
            style: Fonts.inter(
              fontSize: 11,
              color: const Color(0xFF313341),
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 16 / 417,
              horizontal: MediaQuery.of(context).size.width * 16 / 218,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 8 / 417,
                    horizontal: MediaQuery.of(context).size.width * 10 / 218,
                  ),
                  height: MediaQuery.of(context).size.height * 108 / 417,
                  decoration: BoxDecoration(
                    color: const Color(0x97FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 24 / 417,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tomorrow",
                              style: Fonts.inter(
                                color: const Color(0xFF303345),
                                fontSize: 7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    "${widget.dailyWeather[WeatherDaily.apparent_temperature_max]!.values[today.add(aDay)]!.round()} °"),
                                SvgPicture.asset(
                                  path,
                                  height: MediaQuery.of(context).size.height *
                                      24 /
                                      417,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 28 / 218,
                          vertical:
                              MediaQuery.of(context).size.height * 11 / 419,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            [
                              "assets/states/rainfall.svg",
                              "${widget.dailyWeather[WeatherDaily.rain_sum]!.values[today.add(aDay)]!.round()} ${widget.dailyWeather[WeatherDaily.rain_sum]!.unit}"
                            ],
                            [
                              "assets/states/wind.svg",
                              "${widget.dailyWeather[WeatherDaily.wind_speed_10m_max]!.values[today.add(aDay)]!.round()} ${widget.dailyWeather[WeatherDaily.wind_speed_10m_max]!.unit}"
                            ],
                            [
                              "assets/states/humidity.svg",
                              "${getSumOfDay(widget.hourlyHumidity.values, today) ~/ 24} %"
                            ],
                          ].map(
                            (value) {
                              return Column(
                                children: [
                                  SvgPicture.asset(
                                    height: MediaQuery.of(context).size.height *
                                        22 /
                                        419,
                                    value[0],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        8 /
                                        419,
                                  ),
                                  Text(
                                    value[1],
                                    style: Fonts.inter(
                                      color: const Color(0xFF303345),
                                      fontSize: 7,
                                    ),
                                  )
                                ],
                              );
                            },
                          ).toList() as List<Widget>,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 16 / 417,
                ),
                Expanded(
                    child: ListView(
                  children: the6Days,
                ))
              ],
            )),
      ),
    );
  }
}
