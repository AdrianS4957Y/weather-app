// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:weathers/pages/loading/loading.dart';
import 'package:weathers/pages/main/main.dart';
import 'package:weathers/pages/search/search.dart';

class Routes {
  static const main = "/";
  static const search = "/search";
  static const loading = "/loading";
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final WidgetBuilder builder = switch (settings.name) {
      "$main" => (context) => const Main(),
      "$search" => (context) => const Search(),
      "$loading" => (context) => const Loading(),
      _ => (context) => const Main(),
    };
    return MaterialPageRoute(
      settings: settings,
      builder: builder,
    );
  }
}
