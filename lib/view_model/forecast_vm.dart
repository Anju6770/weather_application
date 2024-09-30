import 'package:get/get.dart';
import 'package:weather_application/models/forecast_model.dart';
import 'package:weather_application/services/http_services.dart';

class ForecastVM extends GetxController {
  bool isLoading = false;
  List<ForecastModel> forecastData = [];

  // Fetch forecast data based on current location
  vmGetForecastData() async {
    await _fetchForecastData();
  }

  // Fetch forecast data based on a city name
  Future<void> vmGetForecastDataByCity(String city) async {
    await _fetchForecastData(city: city);
  }

  // Private method to fetch forecast data
  Future<void> _fetchForecastData({String? city}) async {
    try {
      isLoading = true;
      update();

      // Fetch the forecast data from the service
      forecastData = await HttpServices().fetchForecastData(city: city);

      isLoading = false;
      update();
    } catch (e) {
      print(e);
      isLoading = false;  // Ensure loading is set to false on error
      update();
    }
  }
}
