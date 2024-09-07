import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:weathers/globals/fonts.dart';

class SkyStatus extends StatefulWidget {
  final Map<dynamic, ParameterValue> currentWeather;
  const SkyStatus({
    super.key,
    required this.currentWeather,
  });

  @override
  SkyStatusState createState() => SkyStatusState();
}

skyStatePathGenerator({
  num? isDay,
  num? cloudCover,
  num? snowFall,
  num? rain,
  num? windSpeed,
}) {
  String path = "assets/sky_states/";
  path += (isDay != null && isDay == 1 ? "day" : "night");
  if (cloudCover != null) {
    if (cloudCover <= 20) {
      path += "";
    } else if (cloudCover <= 50) {
      path += "_cloudy";
    } else {
      path = path.replaceFirst("day", "cloud").replaceFirst('night', 'cloud');
    }
  }
  if (snowFall != 0) {
    if (!path.contains("_cloudy")) {
      path += "_cloudy";
    }
    path += "_snowy";
  } else if (rain != 0) {
    if (!path.contains("_cloudy")) {
      path += "_cloudy";
    }
    path += "_rainy";
  }
  if (windSpeed != null) {
    if (windSpeed / 3.6 > 8 /* km/h -> m/s */) {
      path += "_windy";
    }
  }
  path += '.svg';
  return path;
}

class SkyStatusState extends State<SkyStatus> {
  @override
  Widget build(BuildContext context) {
    String weatherStatus = "Sunny";
    String path = "assets/sky_states/";
    path += (widget.currentWeather[WeatherCurrent.is_day]?.value == 1
        ? "day"
        : "night");
    weatherStatus = widget.currentWeather[WeatherCurrent.is_day]?.value == 1
        ? "Sunny"
        : "Clear night";
    if (widget.currentWeather[WeatherCurrent.cloud_cover]?.value != null) {
      if (widget.currentWeather[WeatherCurrent.cloud_cover]!.value <= 20) {
        path += "";
      } else if (widget.currentWeather[WeatherCurrent.cloud_cover]!.value <=
          50) {
        path += "_cloudy";
        weatherStatus = "Cloudy";
      } else {
        path = path.replaceFirst("day", "cloud").replaceFirst('night', 'cloud');
        weatherStatus = "Cloudy";
      }
    }
    if (widget.currentWeather[WeatherCurrent.snowfall]?.value != null) {
      if (widget.currentWeather[WeatherCurrent.snowfall]!.value != 0) {
        path += "_snowy";
        weatherStatus = "Snowy";
      }
    } else if (widget.currentWeather[WeatherCurrent.rain]?.value != null) {
      if (widget.currentWeather[WeatherCurrent.rain]!.value != 0) {
        path += "_rainy";
        weatherStatus = "Rainy";
      }
    }
    if (widget.currentWeather[WeatherCurrent.wind_speed_10m]?.value != null) {
      if (widget.currentWeather[WeatherCurrent.wind_speed_10m]!.value / 3.6 >
          8 /* km/h -> m/s */) {
        path += "_windy";
        weatherStatus = "Windy";
      }
    }
    path += '.svg';
    return SizedBox(
      height: MediaQuery.of(context).size.height * 88 / 471,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            path,
            height: MediaQuery.of(context).size.height * 80 / 471,
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text:
                      "${widget.currentWeather[WeatherCurrent.apparent_temperature]?.value.round()}",
                  style: Fonts.inter(
                    fontSize: 43,
                    color: const Color(0xFF303345),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                weatherStatus,
                style: Fonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF303345),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "° C",
              style: Fonts.inter(color: const Color(0xFF303345), fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
