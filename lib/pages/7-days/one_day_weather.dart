import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weathers/globals/fonts.dart';

class OneDayWeather extends StatefulWidget {
  final String path;
  final int temperature;
  final DateTime day;
  const OneDayWeather({
    super.key,
    required this.path,
    required this.temperature,
    required this.day,
  });

  @override
  OneDayWeatherState createState() => OneDayWeatherState();
}

class OneDayWeatherState extends State<OneDayWeather> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 5 / 417),
      child: Container(
          decoration: BoxDecoration(
            color: const Color(0x5BFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 11 / 218),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 38 / 417,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("EEEE", "en_US").format(widget.day),
                style: Fonts.inter(
                  color: const Color(0xFF303345),
                  fontSize: 7,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${widget.temperature} °",
                    style: Fonts.inter(
                      color: const Color(0xFF303345),
                      fontSize: 7,
                    ),
                  ),
                  SvgPicture.asset(
                    widget.path,
                    height: MediaQuery.of(context).size.height * 24 / 417,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
