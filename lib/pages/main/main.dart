import 'package:flutter/material.dart';
import 'package:weathers/api/weather.dart';
import 'package:weathers/globals/fonts.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/globals/routes.dart';

class Main extends StatefulWidget {
  const Main({
    super.key,
  });

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.height > 480 &&
        MediaQuery.of(context).size.height < 800) {
      setFontSizeMultiplier(1.5);
    } else if (MediaQuery.of(context).size.height < 1000) {
      setFontSizeMultiplier(1.8);
    } else {
      setFontSizeMultiplier(2);
    }
    Weather();
    return Scaffold(
      body: Container(
        decoration: backgroundGradient,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
            ),
            Image.asset(
              "assets/rainy_big.png",
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.28,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.068,
            ),
            Center(
              child: Text(
                "Weather App Name",
                textAlign: TextAlign.center,
                style: Fonts.poppins(
                  color: const Color(0xFF303345),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.068,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.search);
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  Color(0xFFfbdac3),
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.0825,
                  vertical: MediaQuery.of(context).size.height * 0.025,
                )),
              ),
              child: Text(
                "Click to find your town",
                style: Fonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xE6303345)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
            ),
          ],
        ),
      ),
    );
  }
}
