import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/constants/contant.dart';
import 'package:weather_application/models/forecast_model.dart';
import 'package:weather_application/models/weather_model.dart';
import 'package:weather_application/services/location_services.dart';

class HttpServices {
  Future<WeatherModel> fetchWeatherData() async {
    Position position = await LocationServices().determinePosition();
    final endPoint =
        "?lat=${position.latitude}&lon=${position.longitude}&appid=";
    final url = "${baseUrlWeather}${endPoint}${key}&units=metric";
    final response = await http.get(Uri.parse(url));
    final weatherData = jsonDecode(response.body);
    print("WeatherDataaaaaaaaaaaaaaaa: ${weatherData}");
    return WeatherModel.fromMap(weatherData);
  }

  Future<List<ForecastModel>> fetchForecastData({String? city}) async {
    String url;

    if (city != null && city.isNotEmpty) {
      // If a city is provided, construct the URL to fetch data by city name
      url = "${baseUrlForecast}?q=${city}&appid=${key}&units=metric";
    } else {
      // Otherwise, fetch data by current latitude and longitude
      Position position = await LocationServices().determinePosition();
      final endPoint =
          "?lat=${position.latitude}&lon=${position.longitude}&appid=";
      url = "${baseUrlForecast}${endPoint}${key}&units=metric";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List forecastData = data['list'];
      print("Forecast Data: ${forecastData}");
      return forecastData
          .map((forecast) => ForecastModel.fromMap(forecast))
          .toList();
    } else {
      throw Exception("Failed to load forecast data");
    }
  }
}

