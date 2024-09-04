import 'package:flutter/material.dart';
import 'package:weathers/api/weather.dart';

class WeatherState extends InheritedWidget {
  final Weather weather;
  const WeatherState({super.key, required super.child, required this.weather});
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
