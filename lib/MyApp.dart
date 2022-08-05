import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/configs/LocalString.dart';
import 'package:assignment/configs/Routes.dart';
import 'package:assignment/ui/SplashScreen.dart';
import 'package:assignment/ui/home/home_screen.dart';
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    //NotificationService.instance.start();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: LocalString.kAppName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
            fontFamily: 'Avenir',
            primaryColorLight: AppColors.colorAccent,
            primaryColorDark: AppColors.colorPrimaryDark,
            primaryColor: AppColors.colorPrimary,
            splashColor: AppColors.colorPrimary,
            backgroundColor: Colors.white,
            appBarTheme: new AppBarTheme(
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Colors.white,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
              elevation: 10,
              color: AppColors.colorPrimary,
            )),

        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          Routes.home_screen: (BuildContext context) => new HomeScreen(),
        });
  }
}
