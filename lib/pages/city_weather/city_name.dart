import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathers/api/json/city.dart';
import 'package:weathers/globals/fonts.dart';

class CityName extends StatelessWidget {
  final City city;
  const CityName({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "${city.asciiName},\n${city.countryName}",
          style: Fonts.inter(
              fontSize: 20,
              color: const Color(0xFF313341),
              fontWeight: FontWeight.w500),
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        Text(
          DateFormat('EEE, MMM d').format(DateTime.now()),
          style: Fonts.inter(fontSize: 9, color: const Color(0xFF9A938C)),
        )
      ],
    );
  }
}
