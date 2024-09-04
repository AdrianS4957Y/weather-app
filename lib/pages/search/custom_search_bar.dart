import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weathers/globals/fonts.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onChange;
  const CustomSearchBar({
    super.key,
    required this.onChange,
  });

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 31 / 471,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 9 / 218),
        decoration: BoxDecoration(
          color: const Color(0x99FFFFFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    "assets/search_icon.png",
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 20 / 471,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: widget.onChange,
                      onSubmitted: (value) {
                        setState(() {
                          animate = true;
                        });
                      },
                      style: Fonts.inter(
                        fontSize: 8,
                        color: Color.fromARGB(255, 41, 27, 27),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 10 / 218,
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        fillColor: const Color(0xFF848484),
                        hintText: "Enter name of city",
                        labelStyle: Fonts.inter(
                          fontSize: 8,
                          color: const Color(0xFF848484),
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: Fonts.inter(
                          fontSize: 8,
                          color: const Color(0xFF848484),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ),
                  animate
                      ? LoadingAnimationWidget.discreteCircle(
                          color: const Color(0xFFFFFFFF),
                          size: MediaQuery.of(context).size.width * 15 / 218,
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 15 / 218,
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
