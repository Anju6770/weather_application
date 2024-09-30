import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/constants/contant.dart';
import 'package:weather_application/goggle.dart';
import 'package:weather_application/view_model/forecast_vm.dart';
import 'package:weather_application/view_model/weather_vm.dart';

class WeatherView extends StatefulWidget {
  WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherVM ms = Get.find<WeatherVM>();
  ForecastVM cs = Get.find<ForecastVM>();
  bool isHourlyForecast = true;

  @override
  void initState() {
    super.initState();
    cs.vmGetForecastData();
    ms.vmGetWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WeatherVM>(builder: (_) {
        return GetBuilder<ForecastVM>(builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff22007c), Color(0xff9ba9ff)],
              ),
            ),
            child: Column(
              children: [
                Gap(100),
                customView(),
              ],
            ),
          );
        });
      }),
    );
  }

  Widget customView() {
    if (ms.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (ms.weatherData == null) {
      return Center(child: Text("No data found"));
    } else {
      final firstForecast = cs.forecastData.isNotEmpty ? cs.forecastData[0] : null;

      return Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${ms.weatherData!.country}",
                  style: myStyle(25, Colors.white),
                ),
                Gap(10),
                Text(
                  "${ms.weatherData!.city}",
                  style: myStyle(25, Colors.white),
                ),
              ],
            ),
            Text(
              "${firstForecast?.description ?? ms.weatherData!.description}",
              style: myStyle(23, Colors.white.withOpacity(0.6)),
            ),
            Gap(20),
            Text(
              "${firstForecast != null ? firstForecast.temperature : ms.weatherData!.temperature}°C",
              style: myStyle(35, Colors.white),
            ),
            Container(
              height: 220,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "${iconStartPoint}${firstForecast?.icon ?? ms.weatherData!.icon}${iconEndPoint}"),
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: myStyle(19, Colors.white),
            ),
            Text(
              "${DateFormat('hh:mm a').format(DateTime.now())}",
              style: myStyle(18, Colors.white),
            ),
          ],
        ),
      );
    }
  }

  Widget customWidget() {
    if (cs.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (cs.forecastData.isEmpty) {
      return Center(child: Text("No data found"));
    } else {
      return SizedBox(
        height: 260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cs.forecastData.length,
          itemBuilder: (context, index) {
            final forecast = cs.forecastData[index];
            DateTime forecastTime = DateTime.now().add(Duration(hours: index));

            return Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(40),
                color: Color(0xff9ba9ff).withOpacity(0.55),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(20),
                    Text(
                      index == 0 ? "Now" : "${forecast.temperature}°C",
                      style: myStyle(20, Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10),
                    CircleAvatar(
                      backgroundColor: Color(0xff9ba9ff).withOpacity(0.01),
                      backgroundImage: NetworkImage(
                        "${iconStartPoint}${forecast.icon}${iconEndPoint}",
                      ),
                      radius: 50,
                    ),
                    Gap(10),
                    Text(
                      DateFormat('h:mm a').format(forecastTime),
                      style: myStyle(20, Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}