import 'package:flutter/material.dart';
import 'package:weathers/globals/routes.dart';

void main() {
  runApp(
    const MaterialApp(
      initialRoute: "/",
      onGenerateRoute: Routes.generateRoutes,
    ),
  );
}
