import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logging/logging.dart';
import 'package:weathers/api/json/city.dart';
import 'package:weathers/api/weather.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/pages/city_weather/city_weather.dart';

class Loading extends StatefulWidget {
  final City city;
  const Loading({
    super.key,
    required this.city,
  });

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      final response = await Weather.getWeather(widget.city);
      Logger('log').info(response);
      return response;
    }).then((response) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityWeather(
            dailyWeather: response.dailyData,
            currentWeather: response.currentData,
            hourlyWeather: response.hourlyData,
            city: widget.city,
          ),
        ),
      );
    });
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFFFFFFFF),
            size: MediaQuery.of(context).size.height * 24 / 471,
          ),
        ),
      ),
    );
  }
}
