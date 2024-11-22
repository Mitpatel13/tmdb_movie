import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_ctrl.dart';
class SplashScreen extends StatelessWidget {

  final splashController = Get.put(SplashController());

   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_splash.jpeg'),
            const Text(
              'Shopping App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
