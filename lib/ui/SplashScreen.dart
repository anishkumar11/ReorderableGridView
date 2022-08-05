import 'dart:async';

import 'package:assignment/configs/LocalString.dart';
import 'package:assignment/configs/Routes.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white70,
          child:Center(
              child: CommonWidgetUtils.getLabel2(LocalString.kAppName,
                  17, FontWeight.w700, Colors.black)
          ) // Foreground widget here
      ),);

  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(Routes.home_screen);
  }



}
