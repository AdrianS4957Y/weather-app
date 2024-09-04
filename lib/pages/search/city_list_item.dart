import 'package:flutter/material.dart';
import 'package:weathers/globals/fonts.dart';
// import 'package:weathers/globals/routes.dart';

class CityListItem extends StatefulWidget {
  final String cityName;
  final Function onClick;
  const CityListItem({
    super.key,
    required this.cityName,
    required this.onClick,
  });

  @override
  CityListItemState createState() => CityListItemState();
}

class CityListItemState extends State<CityListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 5 / 471),
      child: GestureDetector(
        onTapDown: (event) {
          setState(() {
            widget.onClick();
          });
          // Navigator.pushNamed(context, Routes.loading);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x5BFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 11 / 471),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 38 / 471,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.cityName,
              style: Fonts.inter(
                  color: const Color(0xFF303345),
                  fontWeight: FontWeight.w600,
                  fontSize: 7),
            ),
          ),
        ),
      ),
    );
  }
}
