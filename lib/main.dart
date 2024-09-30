import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_application/bindings/weather_binding.dart';
import 'package:weather_application/views/bottom.dart';
import 'package:weather_application/views/forecast_view.dart';
import 'package:weather_application/views/search.dart';
import 'package:weather_application/views/splash_screen.dart';
import 'package:weather_application/views/weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      getPages: [
        GetPage(
            name: '/weather',
            page: () => WeatherView(),
            binding: WeatherBindings(),
        ),
        GetPage(name: '/splashScreen', page: ()=>SplashScreen(),
          binding: WeatherBindings(),
        ),
        GetPage(
            name: '/forecast',
            page: () => ForecastView(),
            binding: WeatherBindings(),
        ),
        GetPage(name: '/bottom',
            page: ()=>PracticeBottomNavBar(),
        binding: WeatherBindings()),
        GetPage(name: '/search',
            page: ()=>WeatherSearch(),
            binding: WeatherBindings())
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
