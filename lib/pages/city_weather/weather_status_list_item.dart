import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weathers/globals/fonts.dart';

class WeatherStatusListItem extends StatefulWidget {
  final String path;
  final List<String> status;
  const WeatherStatusListItem({
    super.key,
    required this.path,
    required this.status,
  });

  @override
  WeatherStatusListItemState createState() => WeatherStatusListItemState();
}

class WeatherStatusListItemState extends State<WeatherStatusListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 5 / 471),
      child: Container(
          decoration: BoxDecoration(
            color: const Color(0x5BFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 11 / 218,
            vertical: MediaQuery.of(context).size.height * 8 / 471,
          ),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 38 / 471,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 22 / 218,
                    height: MediaQuery.of(context).size.height * 22 / 417,
                    child: widget.path.endsWith("svg")
                        ? SvgPicture.asset(
                            widget.path,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            widget.path,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 8 / 218,
                  ),
                  Text(
                    widget.status.first,
                    style: Fonts.inter(
                      color: const Color(0xFF303345),
                      fontSize: 7,
                    ),
                  ),
                ],
              ),
              Text(
                widget.status[1],
                style: Fonts.inter(fontSize: 7, color: const Color(0xFF303345)),
              )
            ],
          )),
    );
  }
}
