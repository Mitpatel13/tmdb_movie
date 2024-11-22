import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/screens/splash_scr.dart';

import 'controller/theme_ctrl.dart';

void main() {
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SplashScreen(),
      );
    });
  }
}
