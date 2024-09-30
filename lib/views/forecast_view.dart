import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_application/constants/contant.dart';
import 'package:weather_application/goggle.dart';
import 'package:weather_application/view_model/forecast_vm.dart';

class ForecastView extends StatefulWidget {
  const ForecastView({super.key});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  ForecastVM cs = Get.find<ForecastVM>();

  bool isHourlyForecast = true;
  @override
  void initState() {
    super.initState();
    cs.vmGetForecastData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForecastVM>(
        builder: (_) {
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
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHourlyForecast = true;
                        });
                      },
                      child: Text(
                        "Hourly Forecast",
                        style: myStyle(25, Colors.white),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey),
                Gap(10),
                Expanded(child: customWidget() ,),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget customWidget() {
    if (cs.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (cs.forecastData.isEmpty) {
      return Center(
        child: Text("No data found"),
      );
    } else {
      return ListView.builder(
        itemCount: cs.forecastData.length,
        itemBuilder: (context, index) {
          final forecast = cs.forecastData[index];
          return Column(
            children: [
              Stack(
                children:[ Container(
                  margin: EdgeInsets.all(10),
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.elliptical(260, 210),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
                    color: Color(0xff9ba9ff).withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(40),
                        Text(
                          "${forecast.temperature}°C",
                          style: myStyle(25, Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Gap(30),
                        Text(Jiffy.parse("${forecast.dateTime}").format(pattern: 'h:mm:ss a'),style: myStyle(16,Colors.white),),
                        Gap(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Jiffy.parse("${forecast.dateTime}").format(pattern: 'MMMM do yyyy'),style: myStyle(18,Colors.white),),
                            Text("${forecast.description}", style: myStyle(23, Colors.black),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                  Positioned(
                      right: 0,
                      child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${iconStartPoint}${forecast.icon}${iconEndPoint}"),fit: BoxFit.cover)
                    ),
                  ))
                ]
              ),
            ],
          );
        },
      );
    }
  }
}
