import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_application/constants/contant.dart';
import 'package:weather_application/goggle.dart';
import 'package:weather_application/view_model/forecast_vm.dart';

class WeatherSearch extends StatefulWidget {
  const WeatherSearch({super.key});

  @override
  State<WeatherSearch> createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  final ForecastVM cs = Get.find<ForecastVM>();
  final TextEditingController _controller = TextEditingController();
  String currentSearch = "";

  @override
  void initState() {
    super.initState();
    cs.vmGetForecastData(); // Fetch initial data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForecastVM>(builder: (_) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    'Weather',
                    style: myStyle(35, Colors.white, FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                      ),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: 'Search for a city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentSearch = value; // Update the current search input
                          });
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              currentSearch = value; // Keep the search input in the text field
                              _controller.text = value; // Keep the text in the search bar
                            });
                            cs.vmGetForecastDataByCity(value); // Fetch data by city
                          }
                        },
                      ),
                    ),
                  ),
                  Center(child: customWidget()),
                ],
              ),
            ),
          ),
        );
      }),
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
        physics: NeverScrollableScrollPhysics(),
        itemCount: cs.forecastData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final forecast = cs.forecastData[index];
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.elliptical(260, 210),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
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
                      Text(
                        Jiffy.parse("${forecast.dateTime}").format(pattern: 'h:mm:ss a'),
                        style: myStyle(16, Colors.white),
                      ),
                      Gap(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Jiffy.parse("${forecast.dateTime}").format(pattern: 'MMMM do yyyy'),
                            style: myStyle(17, Colors.white),
                          ),
                          Text(
                            "${forecast.description}",
                            style: myStyle(23, Colors.black),
                          ),
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
                    image: DecorationImage(
                      image: NetworkImage("${iconStartPoint}${forecast.icon}${iconEndPoint}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
