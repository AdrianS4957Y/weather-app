import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weathers/globals/gradients.dart';
import 'package:weathers/globals/routes.dart';

class Loading extends StatefulWidget {
  const Loading({
    super.key,
  });

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: Random().nextInt(3) + 1), () {
      Navigator.pushNamed(context, Routes.search);
    });
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFFFFFFFF),
            size: MediaQuery.of(context).size.height * 24 / 471,
          ),
        ),
      ),
    );
  }
}
