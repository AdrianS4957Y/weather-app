import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weathers/globals/fonts.dart';

class CurrentDayWeatherListItem extends StatefulWidget {
  final int temperature;
  final String path;
  final int hour;
  const CurrentDayWeatherListItem({
    super.key,
    required this.temperature,
    required this.path,
    required this.hour,
    // required this.hourlyWeather,
  });

  @override
  CurrentDayWeatherListItemState createState() =>
      CurrentDayWeatherListItemState();
}

class CurrentDayWeatherListItemState extends State<CurrentDayWeatherListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 5 / 218,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 8 / 417,
          horizontal: MediaQuery.of(context).size.width * 6 / 218,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: const Border(),
          color: const Color(0x4cFFFFFF),
        ),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.hour}:00",
                style: Fonts.inter(
                  color: const Color(0xFF9C9EAA),
                  fontSize: 7,
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  widget.path,
                  height: MediaQuery.of(context).size.height * 24 / 417,
                ),
              ),
              Text(
                "${widget.temperature} °",
                style: Fonts.inter(fontSize: 7, color: const Color(0xFF303345)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
