
import 'package:assignment/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_bus/event_bus.dart';
import 'MyApp.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();


  Constants.eventBus = EventBus();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_){
    runApp(MyApp());
  });
}
