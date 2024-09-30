import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/views/bottom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Get.offAll(() => PracticeBottomNavBar())
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.99,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/image/we_cover.jpg"),fit: BoxFit.cover)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/image/we_cloud.png"),fit: BoxFit.cover)
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
