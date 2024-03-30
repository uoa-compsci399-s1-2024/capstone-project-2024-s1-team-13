import 'package:flutter/material.dart';
import '../presentation/iphone_14_15_pro_max_two_screen/iphone_14_15_pro_max_two_screen.dart';
import '../presentation/iphone_14_15_pro_max_one_screen/iphone_14_15_pro_max_one_screen.dart';
import '../presentation/iphone_14_15_pro_max_twelve_screen/iphone_14_15_pro_max_twelve_screen.dart';
import '../presentation/iphone_14_15_pro_max_sixteen_screen/iphone_14_15_pro_max_sixteen_screen.dart';
import '../presentation/iphone_14_15_pro_max_fifteen_screen/iphone_14_15_pro_max_fifteen_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String iphone1415ProMaxTwoScreen =
      '/iphone_14_15_pro_max_two_screen';

  static const String iphone1415ProMaxOneScreen =
      '/iphone_14_15_pro_max_one_screen';

  static const String iphone1415ProMaxTwelveScreen =
      '/iphone_14_15_pro_max_twelve_screen';

  static const String iphone1415ProMaxSixteenScreen =
      '/iphone_14_15_pro_max_sixteen_screen';

  static const String iphone1415ProMaxFifteenScreen =
      '/iphone_14_15_pro_max_fifteen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    iphone1415ProMaxTwoScreen: (context) => const Iphone1415ProMaxTwoScreen(),
    iphone1415ProMaxOneScreen: (context) => Iphone1415ProMaxOneScreen(),
    iphone1415ProMaxTwelveScreen: (context) => const Iphone1415ProMaxTwelveScreen(),
    iphone1415ProMaxSixteenScreen: (context) => Iphone1415ProMaxSixteenScreen(),
    iphone1415ProMaxFifteenScreen: (context) => const Iphone1415ProMaxFifteenScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen()
  };
}
